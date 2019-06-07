# Angular CLI performance benchmark

This repository contains performance benchmarks for a few open source Angular CLI projects.

It is used to track the performance of the Angular CLI build system across versions to find regressions.

The current benchmarks can be seen on CircleCI: https://circleci.com/gh/filipesilva/workflows/angular-cli-perf-benchmark


## Benchmark package

We have a private benchmarking package for the CLI https://github.com/angular/angular-cli/tree/master/packages/angular_devkit/benchmark.

To install it, clone the CLI repo, then run follow these commands:
```
yarn
yarn build
npm pack dist/@angular-devkit/benchmark
npm install -g angular-devkit-benchmark-0.800.0-beta.18.tgz
```

The filename on the last command might change, depending on the version of the CLI you clone.

To use it, run `benchmark -- command`. The command will depend on the project you use. To benchmark a prod build, do `benchmark -- ng build --prod`.

You can also do `benchmark --iterations 20 -- ng build --prod` to get a larger sample size (20 instead of 5).


## Methodology

The `./benchmark.project.sh` script contains logic to install and benchmark a project. It's used in the CircleCI configuration to run each project through CI.

For instance, to benchmark a new project, run `./benchmark-project.sh https://github.com/filipesilva/cli-eight-project 02cfbec npm`.

To get the base version first update a project to version 8 following https://update.angular.io/. Thats the base variant and should be in the pulled repository SHA.

The "CLI version 8 with differential loading" is obtained by installing `@angular-devkit/build-angular@0.802.0` and `@angular/cli@8.0.2` and then running the benchmark.

Replacing `target` in `./tsconfig.json` from `es2015` to `es5` makes the "CLI version 8 without differential loading" variant.

The "CLI version 7" variant is obtained by by installing `@angular-devkit/build-angular@0.13.8` and `@angular/cli@7.3.9`.

This gives us the base benchmark suite containing:
- CLI version 8 with differential loading
- CLI version 8 without differential loading
- CLI version 7

This suite is run through node 10 and node 12.