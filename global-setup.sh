set -u -e -o pipefail

echo -e "# Set global npm install directory"
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
echo "export PATH=~/.npm-global/bin:$PATH" >> ~/.profile
source ~/.profile
echo -e "\n# Install global Angular CLI and Benchmark utility"
npm i -g yarn@1.17
npm i -g @angular/cli@9.0.0-rc.10
npm i -g ./angular-devkit-benchmark-0.900.0-next.19.tgz
echo -e "\n# Print npm version"
npm --version
echo -e "\n# Print yarn version"
yarn --version
echo -e "\n# Print ng version"
ng version
