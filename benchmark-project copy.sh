set -u -e -o pipefail
git_url=$1
git_sha=$2
package_manager=$3
command="${4:-ng build --prod}"
dir="${5:-.}"
benchmark_command="benchmark --verbose --watch-timeout=250000 --watch-matcher=Time: --watch-script watch_script.js -- $command"
if [[ "$package_manager" == "npm" ]]; then
    install_package_command="npm install"
fi
if [[ "$package_manager" == "yarn" ]]; then
    install_package_command="yarn add"
fi
install_fw="$install_package_command -S @angular/animations@10.0.0-rc.6 @angular/common@10.0.0-rc.6 @angular/core@10.0.0-rc.6 @angular/elements@10.0.0-rc.6 @angular/forms@10.0.0-rc.6 @angular/platform-browser@10.0.0-rc.6 @angular/platform-browser-dynamic@10.0.0-rc.6 @angular/router@10.0.0-rc.6 @angular/service-worker@10.0.0-rc.6"
install_fw_dev="$install_package_command -D @angular/compiler@10.0.0-rc.6 @angular/compiler-cli@10.0.0-rc.6 @angular/language-service@10.0.0-rc.6 typescript@3.9.5"
install_cli="$install_package_command -D @angular/cli@10.0.0-rc.5 @angular-devkit/build-angular@0.1000.0-rc.5"

# Set to true to debug.
DEBUG=true

if $DEBUG; then
    # Show all commands ran.
    set -o xtrace
    # Don't do benchmark, just do the command instead.
    # benchmark_command="$command"
fi

silent() {
  if $DEBUG; then
    # Don't silence command output.
    $1
  else
    { 
      $1
    } &> /dev/null
  fi
}

echo -e "# Benchmarking $git_url at $git_sha using $package_manager, running \"$command\" in dir \"$dir\""

silent "rm -rf project"
silent "git clone $git_url project"
silent "cd project"
silent "cp ../watch_script.js aio/watch_script.js"
silent "cd $dir"
silent "git checkout $git_sha"
silent "$package_manager install"

echo -e "\n# Install FW \n"
silent "$install_fw"
silent "$install_fw_dev"

echo -e "\n# Install CLI \n"
silent "$install_cli"
npm run ng version

# run ngcc so that first build is not slow which will mess our benchmarks
silent "npx ngcc --properties es2015 browser module main --create-ivy-entry-points"

echo -e "\n# Benchmark Unpatched \n"
$benchmark_command
