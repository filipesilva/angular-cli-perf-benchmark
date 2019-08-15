# Angular CLI performance benchmark

This repository contains performance benchmarks for a few open source Angular CLI projects.

It is used to track the performance of the Angular CLI build system across versions to find regressions.

The current benchmarks can be seen on CircleCI: [![CircleCI](https://circleci.com/gh/filipesilva/angular-cli-perf-benchmark.svg?style=svg)](https://circleci.com/gh/filipesilva/angular-cli-perf-benchmark)


## Benchmark package

We have a private [benchmarking package](https://github.com/angular/angular-cli/tree/master/packages/angular_devkit/benchmark) for the CLI repository. 

A build is included here as `angular-devkit-benchmark-<some-version>.tgz` but you can also build it from source.

To install the provided version, run follow this command:
```
npm install -g angular-devkit-benchmark-0.800.0-beta.18.tgz
```

To use it, run `benchmark -- command`. The command will depend on the project you use. To benchmark a prod build, do `benchmark -- ng build --prod`.

You can also do `benchmark --iterations 20 -- ng build --prod` to get a larger sample size (20 instead of 5).


## Methodology

The `./benchmark.project.sh` script contains logic to install and benchmark a project. It's used in the CircleCI configuration to run each project through CI.

For instance, to benchmark a new project, run `./benchmark-project.sh https://github.com/filipesilva/cli-eight-project 02cfbec npm`.

To get the base version first update a project to version 8 following https://update.angular.io/. Thats the base variant and should be in the pulled repository SHA.

The "CLI version 8 with differential loading" is obtained by installing `@angular-devkit/build-angular@0.803.0-rc.0`, `@angular/cli@8.3.0-rc.0` and `node-sass@4.12.0` and then running the benchmark.

Replacing `target` in `./tsconfig.json` from `es2015` to `es5` makes the "CLI version 8 without differential loading" variant.

The "CLI version 7" variant is obtained by by installing `@angular-devkit/build-angular@0.13.9` and `@angular/cli@7.3.9`.

This gives us the base benchmark suite containing:
- CLI version 8 with differential loading
- CLI version 8 without differential loading
- CLI version 7

This suite is run through node 10 and node 12.


## Results

After gathering new benchmark information, it can be recorded here and commented out from the CircleCI job list. 

It's important to note that the first build of the `CLI version 8 with differential loading` and `CLI version 7` variants will always use more cores and take more memory. 
This happens because `terser-webpack-plugin` uses both parallel processes and a cache that is cleared on reinstalling the node modules. Cache hits don't spawn extra processes nor perform any work.

These results should be updated when either the setup or the project SHA change.

Projects yet to add:
- https://github.com/aviabird/angularspree (not yet updated to 8, and requires a lot of work to update)


### cli-eight-project

New project created by `ng new`.

<details><summary>Node 12.4.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 16074.00 ms (20640.00, 15130.00, 15230.00, 14840.00, 14530.00)
[benchmark]   Average Process usage: 1.98 process(es) (2.73, 1.80, 1.77, 1.79, 1.81)
[benchmark]   Peak Process usage: 5.20 process(es) (6.00, 5.00, 5.00, 5.00, 5.00)
[benchmark]   Average CPU usage: 216.81 % (236.76, 210.82, 211.28, 212.83, 212.38)
[benchmark]   Peak CPU usage: 650.00 % (630.00, 680.00, 610.00, 690.00, 640.00)
[benchmark]   Average Memory usage: 499.17 MB (582.99, 496.15, 468.92, 467.13, 480.64)
[benchmark]   Peak Memory usage: 1114.56 MB (1086.16, 1193.51, 1105.69, 1081.80, 1105.61)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 12648.00 ms (16940.00, 11720.00, 11620.00, 11630.00, 11330.00)
[benchmark]   Average Process usage: 1.30 process(es) (2.48, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.00 process(es) (6.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 184.01 % (218.35, 176.49, 176.06, 175.56, 173.62)
[benchmark]   Peak CPU usage: 416.00 % (620.00, 400.00, 320.00, 410.00, 330.00)
[benchmark]   Average Memory usage: 378.61 MB (539.03, 338.58, 339.45, 336.06, 339.94)
[benchmark]   Peak Memory usage: 903.65 MB (1094.52, 860.21, 813.06, 859.60, 890.86)
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
[benchmark]   Elapsed Time: 98686.00 ms (131080.00, 93560.00, 92440.00, 87730.00, 88620.00)
[benchmark]   Average Process usage: 3.87 process(es) (4.47, 3.64, 3.77, 3.75, 3.70)
[benchmark]   Peak Process usage: 8.00 process(es) (8.00, 8.00, 8.00, 8.00, 8.00)
[benchmark]   Average CPU usage: 172.66 % (173.91, 170.66, 170.95, 175.58, 172.22)
[benchmark]   Peak CPU usage: 930.00 % (1030.00, 920.00, 910.00, 940.00, 850.00)
[benchmark]   Average Memory usage: 1937.28 MB (2023.86, 1900.47, 1929.83, 1925.09, 1907.14)
[benchmark]   Peak Memory usage: 3876.49 MB (3408.40, 4010.02, 3964.11, 4000.04, 3999.85)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 67540.00 ms (103460.00, 60790.00, 60190.00, 57190.00, 56070.00)
[benchmark]   Average Process usage: 1.44 process(es) (3.20, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.00 process(es) (6.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 159.14 % (167.75, 158.77, 153.47, 155.53, 160.21)
[benchmark]   Peak CPU usage: 528.00 % (660.00, 510.00, 490.00, 500.00, 480.00)
[benchmark]   Average Memory usage: 1221.13 MB (1789.40, 1098.35, 1060.82, 1056.86, 1100.23)
[benchmark]   Peak Memory usage: 2020.07 MB (3056.74, 1783.63, 1775.64, 1718.82, 1765.54)
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
[benchmark]   Elapsed Time: 53526.00 ms (62390.00, 51700.00, 50490.00, 50670.00, 52380.00)
[benchmark]   Average Process usage: 2.48 process(es) (3.28, 2.24, 2.21, 2.29, 2.36)
[benchmark]   Peak Process usage: 8.20 process(es) (9.00, 8.00, 8.00, 8.00, 8.00)
[benchmark]   Average CPU usage: 194.85 % (199.36, 191.13, 194.08, 194.45, 195.21)
[benchmark]   Peak CPU usage: 1010.00 % (1020.00, 990.00, 970.00, 1050.00, 1020.00)
[benchmark]   Average Memory usage: 1167.72 MB (1326.27, 1142.03, 1183.99, 1045.92, 1140.40)
[benchmark]   Peak Memory usage: 2633.36 MB (2677.87, 2629.65, 2715.14, 2592.29, 2551.87)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 48508.00 ms (60040.00, 45980.00, 45070.00, 47780.00, 43670.00)
[benchmark]   Average Process usage: 1.37 process(es) (2.85, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.60 process(es) (9.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 170.60 % (184.65, 167.93, 166.56, 166.45, 167.40)
[benchmark]   Peak CPU usage: 666.00 % (930.00, 500.00, 630.00, 610.00, 660.00)
[benchmark]   Average Memory usage: 892.04 MB (1147.27, 920.49, 809.48, 816.47, 766.48)
[benchmark]   Peak Memory usage: 1826.17 MB (2379.44, 1828.97, 1630.54, 1677.62, 1614.28)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 53156.00 ms (64120.00, 47490.00, 50290.00, 52090.00, 51790.00)
[benchmark]   Average Process usage: 1.34 process(es) (2.70, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 169.01 % (174.37, 170.94, 168.18, 164.94, 166.59)
[benchmark]   Peak CPU usage: 554.00 % (860.00, 480.00, 480.00, 480.00, 470.00)
[benchmark]   Average Memory usage: 955.26 MB (1223.15, 904.12, 893.83, 877.39, 877.83)
[benchmark]   Peak Memory usage: 1916.12 MB (2515.05, 1741.12, 1771.47, 1750.21, 1802.74)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 209502.00 ms (236860.00, 196810.00, 200980.00, 197700.00, 215160.00)
[benchmark]   Average Process usage: 1.22 process(es) (2.07, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.60 process(es) (8.00, 1.00, 1.00, 2.00, 1.00)
[benchmark]   Average CPU usage: 178.04 % (182.99, 176.13, 180.18, 178.46, 172.47)
[benchmark]   Peak CPU usage: 701.11 % (1316.67, 555.56, 544.44, 533.33, 555.56)
[benchmark]   Average Memory usage: 1229.03 MB (1337.53, 1215.50, 1160.91, 1221.64, 1209.58)
[benchmark]   Peak Memory usage: 1823.30 MB (2302.79, 1797.55, 1645.40, 1697.55, 1673.20)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 114810.00 ms (143480.00, 105190.00, 105660.00, 108410.00, 111310.00)
[benchmark]   Average Process usage: 1.18 process(es) (1.88, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 172.31 % (170.84, 173.34, 175.02, 172.23, 170.10)
[benchmark]   Peak CPU usage: 622.00 % (910.00, 533.33, 555.56, 555.56, 555.56)
[benchmark]   Average Memory usage: 1090.25 MB (1192.52, 1068.54, 1077.91, 1055.49, 1056.81)
[benchmark]   Peak Memory usage: 1739.53 MB (2171.43, 1671.00, 1599.44, 1590.65, 1665.14)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build 5-ngrx-end --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 60292.00 ms (75120.00, 56080.00, 59490.00, 53690.00, 57080.00)
[benchmark]   Average Process usage: 1.32 process(es) (2.60, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.40 process(es) (8.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 168.80 % (174.17, 166.86, 165.20, 170.58, 167.23)
[benchmark]   Peak CPU usage: 655.56 % (877.78, 640.00, 610.00, 500.00, 650.00)
[benchmark]   Average Memory usage: 762.92 MB (975.47, 711.72, 689.21, 694.61, 743.62)
[benchmark]   Peak Memory usage: 1558.58 MB (2089.78, 1421.06, 1381.95, 1376.15, 1523.96)
```
</details>


### angular.io

From https://github.com/angular/angular/tree/master/aio.

<details><summary>Node 12.4.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 42212.00 ms (51350.00, 41470.00, 40080.00, 39400.00, 38760.00)
[benchmark]   Average Process usage: 6.12 process(es) (8.90, 5.46, 5.53, 5.33, 5.39)
[benchmark]   Peak Process usage: 19.00 process(es) (19.00, 19.00, 19.00, 19.00, 19.00)
[benchmark]   Average CPU usage: 234.84 % (250.96, 227.83, 232.93, 230.47, 231.97)
[benchmark]   Peak CPU usage: 1302.00 % (1620.00, 1220.00, 1110.00, 1400.00, 1160.00)
[benchmark]   Average Memory usage: 1415.94 MB (1597.46, 1355.87, 1392.29, 1382.98, 1351.07)
[benchmark]   Peak Memory usage: 3673.64 MB (3431.00, 3713.58, 3731.44, 3782.65, 3709.51)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 29778.00 ms (39180.00, 27660.00, 27850.00, 26650.00, 27550.00)
[benchmark]   Average Process usage: 2.05 process(es) (6.26, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 4.20 process(es) (17.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 169.34 % (201.48, 161.79, 161.31, 161.81, 160.31)
[benchmark]   Peak CPU usage: 578.00 % (1020.00, 460.00, 460.00, 440.00, 510.00)
[benchmark]   Average Memory usage: 826.43 MB (1264.95, 719.23, 731.12, 691.95, 724.87)
[benchmark]   Peak Memory usage: 1858.30 MB (2949.41, 1748.30, 1695.74, 1438.07, 1459.97)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 30662.00 ms (41600.00, 26050.00, 27450.00, 30360.00, 27850.00)
[benchmark]   Average Process usage: 1.93 process(es) (5.65, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 3.60 process(es) (14.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 165.27 % (172.08, 164.32, 164.24, 162.00, 163.69)
[benchmark]   Peak CPU usage: 463.11 % (470.00, 470.00, 455.56, 480.00, 440.00)
[benchmark]   Average Memory usage: 749.66 MB (1134.57, 668.51, 635.41, 674.54, 635.26)
[benchmark]   Peak Memory usage: 1559.87 MB (2243.94, 1388.45, 1331.79, 1472.00, 1363.19)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 with differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 75902.00 ms (98400.00, 67710.00, 74540.00, 75450.00, 63410.00)
[benchmark]   Average Process usage: 2.07 process(es) (6.34, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 4.00 process(es) (16.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 174.35 % (195.46, 171.01, 166.88, 166.48, 171.93)
[benchmark]   Peak CPU usage: 598.00 % (960.00, 510.00, 520.00, 490.00, 510.00)
[benchmark]   Average Memory usage: 879.77 MB (1232.57, 789.49, 808.39, 782.46, 785.94)
[benchmark]   Peak Memory usage: 1646.09 MB (2323.54, 1490.85, 1535.31, 1403.29, 1477.43)
```
- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 41084.00 ms (48170.00, 35040.00, 40270.00, 40970.00, 40970.00)
[benchmark]   Average Process usage: 1.49 process(es) (3.45, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 2.60 process(es) (9.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 173.33 % (188.38, 173.52, 167.99, 167.72, 169.03)
[benchmark]   Peak CPU usage: 571.56 % (866.67, 490.00, 511.11, 500.00, 490.00)
[benchmark]   Average Memory usage: 676.58 MB (925.45, 626.83, 620.72, 615.95, 593.96)
[benchmark]   Peak Memory usage: 1343.91 MB (1899.36, 1329.31, 1157.89, 1238.77, 1094.24)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build --configuration=stable (at /home/circleci/project/project/aio)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 37114.00 ms (45870.00, 33450.00, 32450.00, 37350.00, 36450.00)
[benchmark]   Average Process usage: 1.91 process(es) (5.56, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 3.60 process(es) (14.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 165.12 % (174.49, 163.10, 164.54, 161.02, 162.47)
[benchmark]   Peak CPU usage: 528.00 % (690.00, 510.00, 470.00, 500.00, 470.00)
[benchmark]   Average Memory usage: 634.71 MB (993.48, 538.10, 555.92, 533.22, 552.81)
[benchmark]   Peak Memory usage: 1348.80 MB (2114.51, 1143.82, 1155.35, 1153.84, 1176.48)
```
</details>


### spartacus

From https://github.com/SAP/cloud-commerce-spartacus-storefront.

Note: this project wasn't using differential loading.

<details><summary>Node 12.4.0</summary>

- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build storefrontapp --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 66336.00 ms (81660.00, 63310.00, 61210.00, 61100.00, 64400.00)
[benchmark]   Average Process usage: 3.19 process(es) (3.66, 3.13, 3.05, 3.08, 3.05)
[benchmark]   Peak Process usage: 6.00 process(es) (6.00, 6.00, 6.00, 6.00, 6.00)
[benchmark]   Average CPU usage: 170.54 % (175.38, 170.71, 167.92, 169.11, 169.57)
[benchmark]   Peak CPU usage: 742.00 % (840.00, 710.00, 740.00, 720.00, 700.00)
[benchmark]   Average Memory usage: 1454.49 MB (1397.44, 1488.81, 1458.56, 1452.97, 1474.66)
[benchmark]   Peak Memory usage: 2865.58 MB (2367.92, 3020.21, 2984.94, 2954.87, 2999.94)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build storefrontapp --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 58398.00 ms (76450.00, 54400.00, 53380.00, 54280.00, 53480.00)
[benchmark]   Average Process usage: 1.27 process(es) (2.35, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 156.36 % (161.60, 154.01, 154.73, 154.99, 156.47)
[benchmark]   Peak CPU usage: 515.13 % (518.18, 536.36, 500.00, 511.11, 510.00)
[benchmark]   Average Memory usage: 961.34 MB (1191.46, 940.76, 885.88, 902.55, 886.03)
[benchmark]   Peak Memory usage: 1657.43 MB (2011.95, 1645.44, 1520.72, 1592.91, 1516.15)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build storefrontapp --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 111002.00 ms (170850.00, 106970.00, 86510.00, 106370.00, 84310.00)
[benchmark]   Average Process usage: 1.29 process(es) (2.44, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 155.95 % (153.03, 152.18, 162.64, 150.85, 161.07)
[benchmark]   Peak CPU usage: 536.22 % (640.00, 510.00, 520.00, 511.11, 500.00)
[benchmark]   Average Memory usage: 1013.15 MB (1275.80, 924.72, 957.92, 983.69, 923.61)
[benchmark]   Peak Memory usage: 1855.15 MB (2291.60, 1706.21, 1791.59, 1724.58, 1761.78)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build storefrontapp --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 52760.00 ms (68310.00, 46380.00, 49680.00, 50970.00, 48460.00)
[benchmark]   Average Process usage: 1.25 process(es) (2.25, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 1.80 process(es) (5.00, 1.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 158.57 % (160.29, 159.66, 157.86, 156.07, 158.99)
[benchmark]   Peak CPU usage: 508.00 % (500.00, 510.00, 520.00, 510.00, 500.00)
[benchmark]   Average Memory usage: 728.57 MB (989.48, 665.76, 663.48, 665.37, 658.76)
[benchmark]   Peak Memory usage: 1331.97 MB (1835.56, 1179.63, 1197.85, 1219.21, 1227.60)
```
</details>


### clarity

From https://github.com/vmware/clarity.

Note: this project wasn't using differential loading.

Note: the Node 12 benchmark had to be taken with `node --max_old_space_size=2400 ./node_modules/@angular/cli/bin/ng build website --prod` instead of `ng build website --prod`. Node 12 dynamically sets the heap size based on available memory, but in the CircleCI default machines (4GB ram) it had to be altered anyway.

<details><summary>Node 12.4.0</summary>

- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   node --max_old_space_size=2400 ./node_modules/@angular/cli/bin/ng build website --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 95504.00 ms (100890.00, 96330.00, 94940.00, 91830.00, 93530.00)
[benchmark]   Average Process usage: 1.38 process(es) (2.89, 1.01, 1.00, 1.01, 1.01)
[benchmark]   Peak Process usage: 9.20 process(es) (36.00, 3.00, 1.00, 3.00, 3.00)
[benchmark]   Average CPU usage: 148.82 % (188.96, 137.25, 138.56, 139.16, 140.18)
[benchmark]   Peak CPU usage: 1444.00 % (5250.00, 490.00, 490.00, 490.00, 500.00)
[benchmark]   Average Memory usage: 1469.60 MB (1599.84, 1411.39, 1457.08, 1412.66, 1467.05)
[benchmark]   Peak Memory usage: 2717.16 MB (4993.50, 2163.15, 2215.24, 2089.87, 2124.03)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   node --max_old_space_size=2400 ./node_modules/@angular/cli/bin/ng build website --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 147158.00 ms (201190.00, 139490.00, 135690.00, 133010.00, 126410.00)
[benchmark]   Average Process usage: 1.18 process(es) (1.90, 1.01, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 8.40 process(es) (36.00, 3.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 156.38 % (170.09, 151.25, 151.50, 156.67, 152.41)
[benchmark]   Peak CPU usage: 954.00 % (2500.00, 740.00, 520.00, 510.00, 500.00)
[benchmark]   Average Memory usage: 1981.30 MB (2041.02, 1945.87, 2002.34, 1947.21, 1970.06)
[benchmark]   Peak Memory usage: 3450.42 MB (6018.51, 2851.30, 2806.87, 2773.70, 2801.71)
```
</details>

<details><summary>Node 10.16.0</summary>

- CLI version 8 without differential loading
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build website --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 125102.00 ms (150050.00, 111270.00, 109290.00, 141540.00, 113360.00)
[benchmark]   Average Process usage: 1.46 process(es) (3.26, 1.01, 1.01, 1.00, 1.01)
[benchmark]   Peak Process usage: 9.60 process(es) (36.00, 3.00, 3.00, 3.00, 3.00)
[benchmark]   Average CPU usage: 156.88 % (199.14, 145.67, 149.47, 142.19, 147.91)
[benchmark]   Peak CPU usage: 1602.67 % (5300.00, 520.00, 733.33, 690.00, 770.00)
[benchmark]   Average Memory usage: 1219.03 MB (1350.21, 1176.10, 1192.34, 1195.58, 1180.93)
[benchmark]   Peak Memory usage: 2409.03 MB (4979.44, 1758.02, 1774.31, 1780.02, 1753.37)
```
- CLI version 7
```
[benchmark] Benchmarking process over 5 iterations, with up to 5 retries.
[benchmark]   ng build website --prod (at /home/circleci/project/project)
[benchmark] Process Stats
[benchmark]   Elapsed Time: 122160.00 ms (120890.00, 113270.00, 161590.00, 112800.00, 102250.00)
[benchmark]   Average Process usage: 1.53 process(es) (3.67, 1.01, 1.00, 1.00, 1.00)
[benchmark]   Peak Process usage: 8.40 process(es) (36.00, 3.00, 1.00, 1.00, 1.00)
[benchmark]   Average CPU usage: 156.52 % (221.59, 144.47, 132.13, 140.85, 143.58)
[benchmark]   Peak CPU usage: 1218.22 % (3700.00, 780.00, 544.44, 533.33, 533.33)
[benchmark]   Average Memory usage: 1198.62 MB (1405.18, 1134.82, 1208.82, 1088.15, 1156.14)
[benchmark]   Peak Memory usage: 2335.99 MB (4962.54, 1781.51, 1672.10, 1604.10, 1659.72)
```
</details>
