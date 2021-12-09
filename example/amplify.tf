resource "aws_amplify_app" "example" {
  name       = "dev-frontend"
  repository = "https://github.com/xxx/xxxx"

  access_token = "xxxxxx"

  build_spec = <<-EOT
    version: 0.1
    frontend:
      phases:
        preBuild:
          commands:
            - yarn install
        build:
          commands:
            - yarn run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

}

resource "aws_amplify_branch" "master" {
  app_id      = aws_amplify_app.example.id
  branch_name = "main"

  framework = "React"
  stage     = "PRODUCTION"
  enable_pull_request_preview=true

}

resource "aws_amplify_domain_association" "example" {
  app_id      = aws_amplify_app.example.id
  domain_name = "hogehoge.com"

  sub_domain {
    branch_name = aws_amplify_branch.master.branch_name
    prefix      = "develop"
  }
}