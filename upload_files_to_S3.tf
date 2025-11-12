# Upload index.html file
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.s3taticweb.bucket
  key          = "index.html"
  source       = "s3taticweb/index.html"
  source_hash  = filemd5("s3taticweb/index.html")
  content_type = "text/html"
}

# Upload error.html file
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.s3taticweb.bucket
  key          = "error.html"
  source       = "s3taticweb/error.html"
  source_hash  = filemd5("s3taticweb/error.html")
  content_type = "text/html"
}

# Upload all CSS files
resource "aws_s3_object" "css_files" {
  for_each     = fileset("s3taticweb/assets/css/", "*.css")
  bucket       = aws_s3_bucket.s3taticweb.bucket
  key          = "assets/css/${each.value}"
  source       = "s3taticweb/assets/css/${each.value}"
  source_hash  = filemd5("s3taticweb/assets/css/${each.value}")
  content_type = "text/css"
}

# Upload all JS files
resource "aws_s3_object" "js_files" {
  for_each     = fileset("s3taticweb/assets/js/", "*.js")
  bucket       = aws_s3_bucket.s3taticweb.bucket
  key          = "assets/js/${each.value}"
  source       = "s3taticweb/assets/js/${each.value}"
  source_hash  = filemd5("s3taticweb/assets/js/${each.value}")
  content_type = "application/javascript"
}

# Upload all webfont files
resource "aws_s3_object" "webfont_files" {
  for_each    = fileset("s3taticweb/assets/webfonts/", "*")
  bucket      = aws_s3_bucket.s3taticweb.bucket
  key         = "assets/webfonts/${each.value}"
  source      = "s3taticweb/assets/webfonts/${each.value}"
  source_hash = filemd5("s3taticweb/assets/webfonts/${each.value}")
  content_type = lookup({
    "eot"   = "application/vnd.ms-fontobject"
    "ttf"   = "font/ttf"
    "woff"  = "font/woff"
    "woff2" = "font/woff2"
    "svg"   = "image/svg+xml"
  }, split(".", each.value)[1], "application/octet-stream")
}

# Upload all image files
resource "aws_s3_object" "image_files" {
  for_each     = fileset("s3taticweb/images/", "*")
  bucket       = aws_s3_bucket.s3taticweb.bucket
  key          = "images/${each.value}"
  source       = "s3taticweb/images/${each.value}"
  source_hash  = filemd5("s3taticweb/images/${each.value}")
  content_type = "image/jpeg"
}