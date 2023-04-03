# mobile-manifest

## Guide

- To clone `production` environment.
  - cd your_directory
  - tsrc init --branch main git@github.com:gotecq/mo.manifest.master.git --group default apps modules libs translations
  - cp -rf mobile-consumer/_/. mobile-consumer && rm -rf mobile-consumer/_

- To edit `manifest.yml` in `.tsrc` folder safely. We can use below command instead of `tsrc sync` to avoid sync latest manifest from github.
  - `cd your_dir` (It's directory where initialize tsrc)
  - `tsrc apply-manifest .tsrc/manifest/manifest.yml --group default apps modules libs translations`

- ref: [https://dmerejkowsky.github.io/tsrc/guide/manifest](https://dmerejkowsky.github.io/tsrc/guide/manifest/)
