Tinymce::Hammer.plugins = %w(paste media autoresize safari mysparql)
Tinymce::Hammer.init = [
  [:cleanup, true],      
  [:paste_convert_headers_to_strong, true],
  [:paste_convert_middot_lists, true],
  [:paste_remove_spans, true],
  [:paste_remove_styles, true],
  [:paste_strip_class_attributes, true],
  [:media_strict, false],
  [:extended_valid_elements, "a[rel|rev|charset|hreflang|tabindex|accesskey|type|name|href|target|title|class|onfocus|onblur|data-formatter],div[data-formatter|data-mysparql-id|data-xslt-type|class|data-parameterised|data-tutorial|data-google-viz|data-google-opts]"],
  [:theme, 'advanced'],
  [:theme_advanced_toolbar_align, 'left'],
  [:theme_advanced_blockformats, 'h2,h3,p'],
  [:theme_advanced_toolbar_location, 'top'],
  [:theme_advanced_buttons1, 'undo,redo,cut,copy,paste,pastetext,|,link,unlink,image,media,|,cleanup,code'],
  [:theme_advanced_buttons2, 'formatselect,bold,italic,strikethrough,blockquote,mysparql,charmap,bullist,numlist,removeformat'],
]
