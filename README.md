# Angular CLI performance benchmark

This repository contains performance benchmarks for a few open source Angular CLI projects.

It is used to track the performance of the Angular CLI build system across versions to find regressions.

The current benchmarks can be seen on CircleCI: [![CircleCI](https://circleci.com/gh/filipesilva/angular-cli-perf-benchmark.svg?style=svg)](https://circleci.com/gh/filipesilva/angular-cli-perf-benchmark)


## Benchmark package

We have a private [benchmarking package](https://github.com/angular/angular-cli/tree/master/packages/angular_devkit/benchmark) for the CLI repository. 

A build is included here as `angular-devkit-benchmark-<some-version>.tgz` but you can also build it from source.

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

The "CLI version 7" variant is obtained by by installing `@angular-devkit/build-angular@0.13.9` and `@angular/cli@7.3.9`.

This gives us the base benchmark suite containing:
- CLI version 8 with differential loading
- CLI version 8 without differential loading
- CLI version 7

This suite is run through node 10 and node 12.


## Results

After gathering new benchmark information, it can be recorded here and commented out from the CircleCI job list. 

These results should be updated when either the setup or the project SHA change.


### cli-eight-project

New project created by `ng new`.

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


### super-productivity

From https://github.com/johannesjo/super-productivity  

<details><summary>Node 12.4.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 161212.00 ms (248480.00, 146940.00, 128300.00, 138220.00, 144120.00)
[benchmark]   Average Process usage: 1.33 process(es) (2.65, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 164.58 % (165.05, 162.88, 165.41, 163.82, 165.75)
[benchmark]   Peak CPU usage: 588.00 % (900.00, 500.00, 500.00, 520.00, 520.00)
[benchmark]   Average Memory usage: 1672.99 MB (2009.92, 1610.42, 1585.67, 1594.23, 1564.71)
[benchmark]   Peak Memory usage: 2444.32 MB (3131.24, 2230.69, 2257.99, 2276.03, 2325.67)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 69132.00 ms (69420.00, 67120.00, 70110.00, 67710.00, 71300.00)
[benchmark]   Average Process usage: 1.03 process(es) (1.13, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.60 process(es) (4.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 163.18 % (166.67, 161.57, 160.68, 163.18, 163.81)
[benchmark]   Peak CPU usage: 517.33 % (520.00, 566.67, 490.00, 510.00, 500.00)
[benchmark]   Average Memory usage: 1339.96 MB (1452.23, 1315.22, 1291.60, 1319.85, 1320.88)
[benchmark]   Peak Memory usage: 2168.81 MB (2289.33, 2126.45, 2101.01, 2155.27, 2172.00)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 68412.00 ms (112680.00, 58400.00, 57000.00, 57080.00, 56900.00)
[benchmark]   Average Process usage: 1.36 process(es) (2.81, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 164.33 % (164.97, 164.84, 161.21, 165.18, 165.43)
[benchmark]   Peak CPU usage: 540.00 % (690.00, 500.00, 500.00, 500.00, 510.00)
[benchmark]   Average Memory usage: 1376.38 MB (1865.59, 1240.44, 1252.33, 1251.08, 1272.46)
[benchmark]   Peak Memory usage: 2254.31 MB (2886.81, 2090.15, 1930.78, 2132.14, 2231.68)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 203022.00 ms (320720.00, 185220.00, 170860.00, 155420.00, 182890.00)
[benchmark]   Average Process usage: 1.35 process(es) (2.75, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 164.51 % (154.16, 163.92, 168.56, 171.13, 164.77)
[benchmark]   Peak CPU usage: 557.11 % (650.00, 555.56, 520.00, 520.00, 540.00)
[benchmark]   Average Memory usage: 1333.09 MB (1709.25, 1234.43, 1236.67, 1225.88, 1259.21)
[benchmark]   Peak Memory usage: 2019.59 MB (2671.33, 1807.51, 1857.44, 1883.19, 1878.46)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 87418.00 ms (91750.00, 94150.00, 92950.00, 77520.00, 80720.00)
[benchmark]   Average Process usage: 1.03 process(es) (1.13, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.60 process(es) (4.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 160.13 % (162.86, 155.83, 158.79, 161.31, 161.87)
[benchmark]   Peak CPU usage: 546.89 % (650.00, 544.44, 520.00, 510.00, 510.00)
[benchmark]   Average Memory usage: 1032.07 MB (1048.05, 1040.10, 1004.07, 999.71, 1068.42)
[benchmark]   Peak Memory usage: 1659.71 MB (1813.00, 1615.65, 1684.55, 1571.28, 1614.09)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 89746.00 ms (145060.00, 78430.00, 77020.00, 77210.00, 71010.00)
[benchmark]   Average Process usage: 1.36 process(es) (2.81, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 156.10 % (152.71, 155.33, 157.43, 156.50, 158.52)
[benchmark]   Peak CPU usage: 548.44 % (680.00, 522.22, 520.00, 520.00, 500.00)
[benchmark]   Average Memory usage: 1086.97 MB (1592.65, 963.42, 960.56, 971.31, 946.89)
[benchmark]   Peak Memory usage: 1702.50 MB (2539.70, 1438.24, 1606.59, 1474.61, 1453.35)
```
</details>


### awesome-angular-workshop

From https://github.com/johnpapa/awesome-angular-workshop/tree/v8

<details><summary>Node 12.4.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 156410.00 ms (197520.00, 157440.00, 148010.00, 138290.00, 140790.00)
[benchmark]   Average Process usage: 1.21 process(es) (2.07, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 168.87 % (172.53, 172.65, 165.35, 164.81, 169.01)
[benchmark]   Peak CPU usage: 562.89 % (760.00, 544.44, 510.00, 500.00, 500.00)
[benchmark]   Average Memory usage: 1487.91 MB (1593.84, 1456.57, 1481.45, 1496.54, 1411.14)
[benchmark]   Peak Memory usage: 2241.79 MB (2508.04, 2160.26, 2180.71, 2211.96, 2148.00)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 73932.00 ms (80630.00, 70620.00, 70510.00, 74400.00, 73500.00)
[benchmark]   Average Process usage: 1.22 process(es) (2.12, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 167.33 % (172.61, 168.49, 166.33, 166.28, 162.93)
[benchmark]   Peak CPU usage: 580.00 % (910.00, 500.00, 490.00, 500.00, 500.00)
[benchmark]   Average Memory usage: 1325.60 MB (1409.88, 1338.53, 1308.61, 1296.29, 1274.70)
[benchmark]   Peak Memory usage: 2117.60 MB (2593.97, 2021.22, 1992.49, 2027.29, 1953.04)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 43992.00 ms (62020.00, 41150.00, 39470.00, 39260.00, 38060.00)
[benchmark]   Average Process usage: 1.30 process(es) (2.49, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.20 process(es) (7.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 171.69 % (166.77, 172.59, 173.39, 172.78, 172.91)
[benchmark]   Peak CPU usage: 520.44 % (640.00, 470.00, 511.11, 511.11, 470.00)
[benchmark]   Average Memory usage: 935.52 MB (1203.61, 861.44, 884.97, 860.04, 867.53)
[benchmark]   Peak Memory usage: 1880.01 MB (2295.31, 1760.51, 1812.83, 1758.79, 1772.59)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 154096.00 ms (172680.00, 154830.00, 135320.00, 148700.00, 158950.00)
[benchmark]   Average Process usage: 1.21 process(es) (2.06, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 184.25 % (190.15, 184.53, 182.88, 180.70, 182.99)
[benchmark]   Peak CPU usage: 624.22 % (1000.00, 544.44, 533.33, 510.00, 533.33)
[benchmark]   Average Memory usage: 1249.97 MB (1359.20, 1255.38, 1180.96, 1200.51, 1253.77)
[benchmark]   Peak Memory usage: 1833.70 MB (2306.31, 1755.37, 1656.79, 1667.64, 1782.40)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 84186.00 ms (96940.00, 81840.00, 86130.00, 76910.00, 79110.00)
[benchmark]   Average Process usage: 1.21 process(es) (2.06, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 179.79 % (184.19, 179.20, 181.55, 177.70, 176.30)
[benchmark]   Peak CPU usage: 608.00 % (944.44, 520.00, 520.00, 555.56, 500.00)
[benchmark]   Average Memory usage: 1094.06 MB (1190.41, 1062.42, 1080.03, 1073.69, 1063.73)
[benchmark]   Peak Memory usage: 1730.95 MB (2185.47, 1606.15, 1606.99, 1670.84, 1585.29)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 47882.00 ms (56390.00, 44480.00, 45680.00, 44070.00, 48790.00)
[benchmark]   Average Process usage: 1.30 process(es) (2.49, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.20 process(es) (7.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 171.52 % (170.94, 172.96, 172.61, 172.77, 168.30)
[benchmark]   Peak CPU usage: 576.00 % (550.00, 490.00, 570.00, 640.00, 630.00)
[benchmark]   Average Memory usage: 763.98 MB (979.70, 705.68, 699.68, 702.88, 731.97)
[benchmark]   Peak Memory usage: 1524.36 MB (1908.33, 1446.94, 1398.45, 1429.33, 1438.78)
```
</details>
