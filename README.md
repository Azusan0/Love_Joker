# Love_Joker

520诈骗链接

## QQ 空间整蛊页

这个目录里现在有：

- `index.html`：整蛊页本体
- `share.html`：发 QQ 空间时更适合使用的分享入口页
- `prank-image.jpg`：已经接入的整蛊图
- `share-cover.png`：给 QQ 空间抓取的分享卡片封面
- `share-cover.html`：封面图的可编辑源页面
- `edgeone.json`：给 EdgeOne Pages 用的静态配置
- `set-public-url.ps1`：切换公开访问地址时用的一键替换脚本

## 直接预览

1. 直接打开 `index.html` 看效果。
2. 点击“继续看”会显示整蛊图。
3. 点击蒙层空白处或“返回上一页”会回到信件页。
4. 发 QQ 空间时，优先发 `share.html` 对应的链接。

## 你最可能会改的地方

打开 `index.html` 后，优先改这几处：

1. `<title>`：分享标题
2. `<meta name="description">`：分享摘要
3. `.letter` 里的正文：首屏假装表白信的内容
4. `.prank__caption`：整蛊图出现后的底部文案
5. `share-cover.html`：如果你想改分享卡片上的标题、摘要或链接文字
6. `share.html`：如果你想改分享入口页的标题、摘要或跳转速度
7. `set-public-url.ps1`：如果你换成新的公开域名或项目地址，用它批量更新页面里的绝对链接

## 切换公开地址

如果你后面把页面迁到新的托管地址，比如 EdgeOne Pages 项目域名，可以在这个目录里运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\set-public-url.ps1 -PublicUrl "https://your-public-site.example"
```

例如：

```powershell
powershell -ExecutionPolicy Bypass -File .\set-public-url.ps1 -PublicUrl "https://demo.pages.dev"
```

它会更新：

- `index.html` 里的 canonical / og / itemprop / twitter 链接
- `share.html` 里的 canonical / og / itemprop / twitter 链接

## EdgeOne Pages 备注

- 这是一个纯静态站，导入 Git 仓库时可以直接用仓库根目录作为输出目录。
- `edgeone.json` 里已经给 `index.html` 和 `share.html` 配了不缓存策略，方便你改卡片信息后更快生效。

## QQ 空间发出去更像样的小建议

1. 现在已经有一张 `share-cover.png`，你也可以按自己的口味替换。
2. 标题不要写得太夸张，越像认真写的小页面越容易点开。
3. 摘要用一句平静的话就够了，比如“有些话还是想认真和你说”。

## 不买域名怎么发

### Cloudflare Pages

1. 新建一个 Pages 项目。
2. 上传这个文件夹里的内容，或把它放进 git 仓库后连接仓库。
3. 直接用生成的 `*.pages.dev` 链接。

### GitHub Pages

1. 新建一个仓库，把这个目录里的文件传上去。
2. 打开 Pages。
3. 用生成的 `github.io` 链接发到 QQ 空间。

## 说明

- 页面按手机浏览做了优化，适合 QQ 空间打开。
- 整蛊图是在页面内显示，不靠浏览器弹窗，成功率更高。
- 如果你之后换图，直接用同名文件替换 `prank-image.jpg` 就行。
