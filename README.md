# mobile-manifest

## Usage

- Navigate to your directory: `cd your_dir`
- Initialize with tsrc: `tsrc init git@gitlab.com:gotecq-mobile/mobile-manifest.git`
- Sync repos: `tsrc sync && cp -f mobile-consumer/_/* mobile-consumer && rm -rf mobile-consumer/_`

## Notes

- To edit `manifest.yml` in `.tsrc` folder safely. We can use below command instead of `tsrc sync` to avoid sync manifest latest from gitlab.

    + `cd your_dir`
    + `tsrc apply-manifest .tsrc/manifest/manifest.yml`
