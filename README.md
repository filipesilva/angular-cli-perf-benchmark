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

## Results

After gathering new benchmark information, it can be recorded here and commented out from the CircleCI job list. 

These results should be updated when either the setup or the project SHA change.

### cli-eight-project

<details><summary>Node 10.16.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 25530.00 ms (34870.00, 24050.00, 21440.00, 23450.00, 23840.00)
[benchmark]   Average Process usage: 1.29 process(es) (2.47, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 184.34 % (197.62, 179.17, 181.48, 180.97, 182.43)
[benchmark]   Peak CPU usage: 500.22 % (533.33, 511.11, 500.00, 490.00, 466.67)
[benchmark]   Average Memory usage: 510.76 MB (674.68, 463.29, 472.84, 487.71, 455.30)
[benchmark]   Peak Memory usage: 1030.30 MB (1088.06, 996.43, 1012.20, 1055.23, 999.57)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 14972.00 ms (16540.00, 14130.00, 14940.00, 14520.00, 14730.00)
[benchmark]   Average Process usage: 1.08 process(es) (1.42, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.60 process(es) (4.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 178.34 % (190.38, 175.70, 176.70, 175.02, 173.90)
[benchmark]   Peak CPU usage: 458.00 % (450.00, 430.00, 460.00, 490.00, 460.00)
[benchmark]   Average Memory usage: 368.96 MB (426.35, 353.38, 365.57, 354.46, 345.05)
[benchmark]   Peak Memory usage: 906.37 MB (931.14, 880.00, 937.02, 893.53, 890.17)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 15852.00 ms (21750.00, 14930.00, 15320.00, 13930.00, 13330.00)
[benchmark]   Average Process usage: 1.25 process(es) (2.25, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 173.49 % (181.01, 168.80, 169.67, 173.82, 174.14)
[benchmark]   Peak CPU usage: 502.00 % (700.00, 450.00, 470.00, 400.00, 490.00)
[benchmark]   Average Memory usage: 361.75 MB (495.78, 334.88, 327.84, 324.83, 325.43)
[benchmark]   Peak Memory usage: 839.92 MB (909.26, 824.16, 806.54, 821.72, 837.93)
```
</details>

<details><summary>Node 12.4.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 21760.00 ms (30060.00, 19530.00, 19730.00, 19830.00, 19650.00)
[benchmark]   Average Process usage: 1.29 process(es) (2.46, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 182.18 % (195.21, 179.67, 178.58, 178.04, 179.42)
[benchmark]   Peak CPU usage: 414.00 % (520.00, 350.00, 370.00, 480.00, 350.00)
[benchmark]   Average Memory usage: 590.44 MB (744.08, 551.52, 559.77, 531.72, 565.12)
[benchmark]   Peak Memory usage: 1139.92 MB (1191.49, 1154.62, 1196.79, 986.98, 1169.75)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 13452.00 ms (15040.00, 14830.00, 12730.00, 12330.00, 12330.00)
[benchmark]   Average Process usage: 1.10 process(es) (1.48, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.60 process(es) (4.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 178.19 % (193.38, 171.08, 175.63, 175.33, 175.53)
[benchmark]   Peak CPU usage: 444.00 % (420.00, 410.00, 490.00, 430.00, 470.00)
[benchmark]   Average Memory usage: 391.04 MB (461.93, 383.10, 361.04, 376.34, 372.79)
[benchmark]   Peak Memory usage: 946.90 MB (933.73, 947.05, 942.14, 989.29, 922.26)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 14078.00 ms (20480.00, 14540.00, 12830.00, 11420.00, 11120.00)
[benchmark]   Average Process usage: 1.28 process(es) (2.38, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 173.17 % (177.22, 164.19, 171.78, 176.55, 176.10)
[benchmark]   Peak CPU usage: 360.00 % (430.00, 320.00, 380.00, 340.00, 330.00)
[benchmark]   Average Memory usage: 392.06 MB (576.98, 348.03, 345.16, 341.52, 348.61)
[benchmark]   Peak Memory usage: 908.22 MB (1063.15, 879.80, 860.92, 871.99, 865.27)
```
</details>