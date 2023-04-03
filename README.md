# mobile-manifest

## Guide

- To clone `production` environment.
  - `cd your_dir`
  - `tsrc init git@github.com:gotecq/mo.manifest.master.git --group default apps modules libs translations modules_member modules_provider`
  - `cp -rf mobile-consumer/_/. mobile-consumer && rm -rf mobile-consumer/_`
  
- To sync:
  - `tsrc sync --group default apps modules libs translations modules_member modules_provider`

- To edit `manifest.yml` in `.tsrc` folder safely. We can use below command instead of `tsrc sync` to avoid sync latest manifest from github.
  - `cd your_dir` (It's directory where initialize tsrc)
  - `tsrc apply-manifest .tsrc/manifest/manifest.yml --group default apps modules libs translations modules_member modules_provider`

- ref: [https://dmerejkowsky.github.io/tsrc/guide/manifest](https://dmerejkowsky.github.io/tsrc/guide/manifest/)
