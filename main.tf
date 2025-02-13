# Configuracao do provider AWS
provider "aws" {
  region = "us-east-1"  # Regiao da AWS 
}
# Criar o grupo DevOps
resource "aws_iam_group" "devops" {
  name = "DevOps"
}
# Criar a politica de leitura do EC2
resource "aws_iam_policy" "ec2_readonly" {
  name        = "EC2ReadOnly"
  description = "Permissoes de leitura no EC2"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "ec2:Describe*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
# Associar a politica ao grupo DevOps
resource "aws_iam_group_policy_attachment" "devops_policy" {
  group      = aws_iam_group.devops.name
  policy_arn = aws_iam_policy.ec2_readonly.arn
}
# Criar o usuario joao_dev
resource "aws_iam_user" "joao_dev" {
  name = "joao_dev"
}
# Associar o usuario ao grupo DevOps
resource "aws_iam_user_group_membership" "joao_dev_group" {
  user  = aws_iam_user.joao_dev.name
  groups = [aws_iam_group.devops.name]
}
