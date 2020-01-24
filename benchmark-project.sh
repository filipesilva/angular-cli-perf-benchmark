set -u -e -o pipefail
git_url=$1
git_sha=$2
package_manager=$3
command="${4:-ng build --prod}"
dir="${5:-.}"
benchmark_command="benchmark --watch-timeout=25000 --watch-matcher=\"Compiled successfully\" --watch-script watch_script.js -- $command"
if [[ "$package_manager" == "npm" ]]; then
    install_package_command="npm install"
fi
if [[ "$package_manager" == "yarn" ]]; then
    install_package_command="yarn add"
fi
install_fw="$install_package_command -S @angular/animations@9.0.0-rc.10 @angular/common@9.0.0-rc.10 @angular/core@9.0.0-rc.10 @angular/elements@9.0.0-rc.10 @angular/forms@9.0.0-rc.10 @angular/platform-browser@9.0.0-rc.10 @angular/platform-browser-dynamic@9.0.0-rc.10 @angular/router@9.0.0-rc.10 @angular/service-worker@9.0.0-rc.10"
install_fw_dev="$install_package_command -D @angular/compiler@9.0.0-rc.10 @angular/compiler-cli@9.0.0-rc.10 @angular/language-service@9.0.0-rc.10 typescript@3.7.5"
install_cli="$install_package_command -D @angular/cli@9.0.0-rc.10 @angular-devkit/build-angular@0.900.0-rc.10"

# Set to true to debug.
DEBUG=false

if $DEBUG; then
    # Show all commands ran.
    set -o xtrace
    # Don't do benchmark, just do the command instead.
    benchmark_command="$command"
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
silent "cd $dir"
silent "git checkout $git_sha"
silent "cp ../../watch_script.js $dir/watch_script.js"
silent "$package_manager install"

echo -e "\n# Install FW \n"
silent "$install_fw"
silent "$install_fw_dev"

echo -e "\n# Install CLI \n"
silent "$install_cli"
npm run ng version

# run ngcc so that first build is not slow which will mess our benchmarks
silent "npx ngcc --properties es2015 browser module main --create-ivy-entry-points"

echo -e "\n# Benchmark CLI version 9 with Ivy\n"
$benchmark_command

# echo -e "\n# Benchmark CLI version 9 with VE\n"
# # Didn't set this one as silent because it's already silent and double escaping is hell.
# sed -i s/\"enableIvy\"\:\ true/\"enableIvy\"\:\ false/g tsconfig.json
# $benchmark_command

# echo -e "\n# Install CLI 7\n"
# silent "$install_cli_7"
# npm run ng version

# echo -e "\n# Benchmark CLI version 7\n"
# $benchmark_command