set -u -e -o pipefail
git_url=$1
git_sha=$2
package_manager=$3
command="${4:-ng build --prod}"
dir="${5:-.}"
benchmark_command="benchmark -- $command"
if [[ "$package_manager" == "npm" ]]; then
    install_package_command="npm install"
fi
if [[ "$package_manager" == "yarn" ]]; then
    install_package_command="yarn add"
fi
install_fw="$install_package_command -S @angular/animations@8.2.2 @angular/common@8.2.2 @angular/core@8.2.2 @angular/elements@8.2.2 @angular/forms@8.2.2 @angular/platform-browser@8.2.2 @angular/platform-browser-dynamic@8.2.2 @angular/router@8.2.2 @angular/service-worker@8.2.2"
install_fw_dev="$install_package_command -D @angular/compiler@8.2.2 @angular/compiler-cli@8.2.2 @angular/language-service@8.2.2 typescript@3.5.3"
install_cli_7="$install_package_command -D @angular/cli@7.3.9 @angular-devkit/build-angular@0.13.9"
install_cli_8="$install_package_command -D @angular/cli@8.3.0-rc.0 @angular-devkit/build-angular@0.803.0-rc.0 node-sass"

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
silent "$package_manager install"

echo -e "\n# Install FW 8\n"
silent "$install_fw"
silent "$install_fw_dev"

echo -e "\n# Install CLI 8\n"
silent "$install_cli_8"
npm run ng version

echo -e "\n# Benchmark CLI version 8 with differential loading\n"
$benchmark_command

echo -e "\n# Benchmark CLI version 8 without differential loading\n"
# Didn't set this one as silent because it's already silent and double escaping is hell.
sed -i s/\"target\"\:\ \"es2015\"/\"target\"\:\ \"es5\"/g tsconfig.json
$benchmark_command

echo -e "\n# Install CLI 7\n"
silent "$install_cli_8"
npm run ng version

echo -e "\n# Benchmark CLI version 7\n"
$benchmark_command