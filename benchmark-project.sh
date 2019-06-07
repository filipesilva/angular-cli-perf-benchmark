git_url=$1
git_sha=$2
package_manager=$3
command="${4:-ng build --prod}"
benchmark_command="benchmark -- $command"
if [[ "$package_manager" == "npm" ]]; then
    install_package_command="npm install -D"
fi
if [[ "$package_manager" == "yarn" ]]; then
    install_package_command="yarn add -D"
fi
install_cli_7="$install_package_command @angular/cli@7.3.9 @angular-devkit/build-angular@0.13.8"
install_cli_8="$install_package_command @angular/cli@8.0.2 @angular-devkit/build-angular@0.800.2"
silent() {
  { 
    $1
  } &> /dev/null
}

set -u -e -o pipefail
# set -o xtrace

echo -e "# Benchmarking $git_url at $git_sha using $package_manager, running \"$command\""

silent "rm -rf project"
silent "git clone $git_url project"
silent "cd project"
silent "git checkout $git_sha"
silent "$package_manager install"

echo -e "\n# CLI version 8 with differential loading\n"
silent "$install_cli_8"
$benchmark_command

echo -e "\n# CLI version 8 without differential loading\n"
# Didn't set this one as silent because it's already silend and double escaping is hell.
sed -i s/\"target\"\:\ \"es2015\"/\"target\"\:\ \"es5\"/g tsconfig.json
$benchmark_command

echo -e "\n# CLI version 7\n"
silent "$install_cli_7"
$benchmark_command