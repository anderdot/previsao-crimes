# Parâmetros
param (
    [string]$diretorio
,   [string]$extensaoOriginal
,   [string]$categoria
,   [string]$extensao
)

# Obtém todos os arquivos com a extensão especificada
$Arquivos = Get-ChildItem -Path $diretorio -Filter $extensaoOriginal

# Loop pelos arquivos e renomeia cada um para o seu periodo (yyyyMM)
foreach ($Arquivo in $Arquivos) {
    # Extrai o periodo (yyyyMM) do nome do arquivo original
    $Periodo = $Arquivo.BaseName -replace "[^\d]", ""

    # Corrige o formato do periodo se for necessÃ¡rio
    if ($Periodo.Length -eq 5) {
        $Ano = $Periodo.Substring(0, 4)
        $Mes = $Periodo.Substring(4, 1)
        if ($Mes.Length -eq 1) {
            $Mes = "0" + $Mes
        }
        $Periodo = $Ano + $Mes
    }

    # Constrói o novo nome do arquivo
    $NovoNomeDoArquivo = $categoria + "_" + $Periodo + $extensao

    # Obtém o caminho completo do arquivo de destino
    $CaminhoDestino = Join-Path -Path $diretorio -Child $NovoNomeDoArquivo

    # Remove caracteres nulos (0x00) do arquivo
    Get-Content $Arquivo.FullName | ForEach-Object { $_ -replace "`0", "" } | Set-Content -Encoding Default $CaminhoDestino

    # Mover os arquivos antigos para a pasta de Original
    $CaminhoOriginal = Join-Path -Path $diretorio -Child "Original"
    if (-not (Test-Path -Path $CaminhoOriginal)) {
        New-Item -ItemType Directory -Path $CaminhoOriginal
    }
    Move-Item $Arquivo.FullName $CaminhoOriginal
}

# Cria a pasta de Processados se ela não existir
$CaminhoProcessados = Join-Path -Path $diretorio -Child "Processados"
if (-not (Test-Path -Path $CaminhoProcessados)) {
    New-Item -ItemType Directory -Path $CaminhoProcessados
}
