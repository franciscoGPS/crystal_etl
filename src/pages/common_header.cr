# pages/common_header.cr
module CommonHeader

  def common_header
    load_css
    load_js
  end

  def load_js
    js_link "https://cdn.jsdelivr.net/npm/luckysheet/dist/plugins/js/plugin.js"
    js_link "https://cdn.jsdelivr.net/npm/luckysheet@2.1.13/dist/luckysheet.umd.js"
    js_link "https://unpkg.com/packery@2/dist/packery.pkgd.min.js"
    js_link "https://unpkg.com/draggabilly@3/dist/draggabilly.pkgd.min.js"
  end

  def load_css
    raw %( <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/luckysheet/dist/plugins/plugins.css" type="text/css"> )
    raw %( <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/luckysheet/dist/css/luckysheet.css" type="text/css"> )
    raw %( <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/luckysheet/dist/assets/iconfont/iconfont.css" type="text/css"> )
    raw %( <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flexboxgrid/6.3.1/flexboxgrid.min.css" type="text/css" > )
  end

end