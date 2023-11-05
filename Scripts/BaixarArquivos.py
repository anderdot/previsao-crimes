# bibliotecas necessárias para o projeto
import subprocess
subprocess.check_call(["pip", "install", "selenium"])
subprocess.check_call(["pip", "install", "webdriver-manager"])

# selenium: É uma biblioteca que permite a automação de interações com navegadores da web.
# selenium.webdriver.common.by: Contém constantes para localizar elementos na página da web. Por exemplo, By.XPATH é usado para localizar elementos por XPATH.
# selenium.webdriver.support: Contém classes e funções relacionadas ao suporte a espera (wait). Ele ajuda a aguardar que certas condições sejam atendidas antes de realizar ações.
# selenium.webdriver.support.ui: Fornece classes para trabalhar com espera explícita e outras operações relacionadas à interface do usuário.
# webdriver_manager.chrome: Ajuda a gerenciar os drivers dos navegadores, como o ChromeDriver, tornando mais fácil a configuração e o download do driver correto para a versão do navegador.
# selenium.webdriver.chrome.options: Contém opções de configuração para o driver do Chrome, como configurar as opções do navegador.
# selenium.webdriver.chrome.service: Permite configurar e personalizar o serviço do ChromeDriver, que controla o navegador Chrome.
# os: Fornece funcionalidades relacionadas ao sistema operacional, criar diretórios, mover arquivos, entre outras operações.
# json: Permite a manipulação de dados no formato JSON, que é comumente usado para armazenar e transmitir dados estruturados.
# re: Fornece suporte para expressões regulares, que são usadas para fazer correspondência de padrões em strings.
# time: Este módulo fornece funções para trabalhar com tempo e atrasos no código.
# datetime: Fornece classes para manipular datas e horas.
# pathlib: Para manipular caminhos de arquivos e diretórios de forma mais eficiente e segura do que usando strings de caminho.

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service as ChromeService
import os
import json
import re
import time
import datetime
from pathlib import Path


# Constantes
# São variáveis que não mudam de valor durante a execução do programa. Para a aplicação elas são essenciais, pois são usadas para definir os caminhos dos arquivos e diretórios, além de definir os botões da raspagem na página web.

DIRETORIO_DOWNLOAD = os.path.join(Path.home(), "Downloads")
ARQUIVO_CONTROLE = 'Controle\Arquivos.json'
BOTOES = {
    'categoria': 'cphBody_btn',
    'ano': 'cphBody_lkAno',
    'mes': 'cphBody_lkMes',
    'exportar': 'cphBody_ExportarBOLink'
}


# Funções de manipulação de Json
# criar_categoria: Cria o json caso não exista, caso exista, adiciona a categoria e cria o diretório dela.
# ordenar_arquivo: Ordena o arquivo json por categoria, ano e mês.
# adicionar_arquivo: Adiciona o arquivo no json e move para o diretorio da categoria.
# adicionar_arquivos_retroativo: Adiciona o arquivo no json passando um diretório, onde ele determina a categoria e move o arquivo para o diretório.
# arquivos_pendentes: Verifica se existem arquivos pendentes de download, caso exista, ele retorna um dicionario com os arquivos pendentes.

def criar_categoria(categoria, expressao, diretorio=None):
    """
    Cria uma categoria de arquivos para serem baixados.

    :param categoria: Nome da categoria.
    :param expressao: Expressão regular para identificar os arquivos da categoria.
    :param diretorio: Diretório onde os arquivos serão salvos. (opcional)
    """
    if diretorio is None:
        diretorio = os.path.join(os.getcwd(), os.path.abspath('..\\'), 'Bases', categoria)
    if not os.path.exists(diretorio):
        os.makedirs(diretorio)

    dados = {}
    if os.path.isfile(ARQUIVO_CONTROLE):
        with open(ARQUIVO_CONTROLE, 'r') as controle:
            dados = json.load(controle)

    if categoria not in dados:
        dados[categoria] = {
            "diretorio": diretorio,
            "expressao": expressao,
            "arquivos": {}
        }

    with open(ARQUIVO_CONTROLE, 'w') as controle:
        json.dump(dados, controle, indent=4)

def ordenar_arquivo():
    """
    Ordena o arquivo de controle de arquivos baixados.
    O arquivo é ordenado por categoria, ano e mês.
    """
    if os.path.isfile(ARQUIVO_CONTROLE):
        with open(ARQUIVO_CONTROLE, 'r') as controle:
            dados = json.load(controle)

        for categoria in dados:
            for ano in dados[categoria]["arquivos"]:
                dados[categoria]["arquivos"][ano] =                    dict(sorted(dados[categoria]["arquivos"][ano].items(),key=lambda item: int(item[0])))
            dados[categoria]["arquivos"] =                dict(sorted(dados[categoria]["arquivos"].items(),key=lambda item: int(item[0])))
        dados = dict(sorted(dados.items(), key=lambda item: item[0]))

        with open(ARQUIVO_CONTROLE, 'w') as controle:
            json.dump(dados, controle, indent=4)

def adicionar_arquivo(categoria, arquivo):
    """
    Adiciona um arquivo baixado ao arquivo de controle.

    :param categoria: Nome da categoria.
    :param arquivo: Nome do arquivo.

    :return: True se o arquivo foi adicionado com sucesso, False caso contrário.
    """
    if os.path.isfile(ARQUIVO_CONTROLE):
        with open(ARQUIVO_CONTROLE, 'r') as controle:
            dados = json.load(controle)

        if categoria in dados:
            caminho_arquivo = os.path.join(DIRETORIO_DOWNLOAD, arquivo)
            coincide = re.search(dados[categoria]["expressao"], arquivo)
            if coincide:
                ano = coincide.group(1)
                mes = coincide.group(2)

                if ano not in dados[categoria]["arquivos"]:
                    dados[categoria]["arquivos"][ano] = {}

                if mes not in dados[categoria]["arquivos"][ano]:
                    dados[categoria]["arquivos"][ano][mes] = {
                        "arquivo": arquivo,
                        "tamanho": f'{os.path.getsize(caminho_arquivo) / 1024:_.0f}'.replace(".", ",").replace("_", ".") + ' KB',
                        "data": str(datetime.datetime.fromtimestamp(os.path.getmtime(caminho_arquivo)))
                    }

                with open(ARQUIVO_CONTROLE, 'w') as controle:
                    json.dump(dados, controle, indent=4)

                ordenar_arquivo()

                try:
                    os.rename(caminho_arquivo, os.path.join(dados[categoria]["diretorio"], arquivo))
                    return True
                except Exception as e:
                    print(f"Erro ao mover o arquivo: {arquivo}")
    return False

def adicionar_arquivos_retroativo(diretorio):
    """
    Adiciona arquivos baixados ao arquivo de controle.

    :param diretorio: Diretório onde os arquivos estão salvos.
    """
    if os.path.isfile(ARQUIVO_CONTROLE):
        with open(ARQUIVO_CONTROLE, 'r') as controle:
            dados = json.load(controle)
        for arquivo in os.listdir(diretorio):
            for categoria in dados:
                coincide = re.search(dados[categoria]["expressao"], arquivo)
                if coincide:
                    ano = coincide.group(1)
                    mes = coincide.group(2)

                    if ano not in dados[categoria]["arquivos"]:
                        dados[categoria]["arquivos"][ano] = {}

                    if mes not in dados[categoria]["arquivos"][ano]:
                        dados[categoria]["arquivos"][ano][mes] = {
                            "arquivo": arquivo,
                            "tamanho": f'{os.path.getsize(os.path.join(diretorio, arquivo)) / 1024:_.0f}'\
                                .replace(".", ",").replace("_", ".") + ' KB',
                            "data": str(datetime.datetime.fromtimestamp(os.path.getmtime(os.path.join(diretorio, arquivo))))
                        }

                    with open(ARQUIVO_CONTROLE, 'w') as controle:
                        json.dump(dados, controle, indent=4)

                    ordenar_arquivo()

                    try:
                        os.rename(os.path.join(diretorio, arquivo), os.path.join(dados[categoria]["diretorio"], arquivo))
                    except Exception as e:
                        print(f"Erro ao mover o arquivo: {arquivo}")

def arquivos_pendentes():
    """
    Retorna os arquivos pendentes de download.

    :return: Dicionário com as categorias, expressao, anos e meses pendentes.
    """
    pendentes = {}
    if os.path.isfile(ARQUIVO_CONTROLE):
        with open(ARQUIVO_CONTROLE, 'r') as controle:
            dados = json.load(controle)
        for categoria in dados:
            # adicionar a expressão regular para a categoria
            pendentes[categoria] = {
                "expressao": dados[categoria]["expressao"],
                "arquivos": {}
            }
            for ano in range(2010, datetime.datetime.now().year + 1):
                pendentes[categoria]["arquivos"][ano] = {}
                if ano == datetime.datetime.now().year:
                    meses = range(1, datetime.datetime.now().month + 1)
                else:
                    meses = range(1, 13)
                meses_pendentes = [mes for mes in meses if str(mes) not in dados[categoria]["arquivos"].get(str(ano), {}).keys()]
                pendentes[categoria]["arquivos"][ano] = meses_pendentes

                if pendentes[categoria]["arquivos"][ano] == []:
                    pendentes[categoria]["arquivos"].pop(ano)
            if pendentes[categoria] == {"expressao": dados[categoria]["expressao"], "arquivos": {}}:
                pendentes.pop(categoria)
    return pendentes


# Funções de manipulação do navegador
# abrir_navegador: Abre uma instância do navegador e retorna o navegador. Adiciona algumas configurações para o navegador como ele não mostrar o navegador, e definir o diretório de download.
# clicar: Clica em um elemento da página web. Utilizando as constantes definidas no início do código.
# verificar_periodo: verifica se o período selecionado tem arquivos a serem baixados.

def abrir_navegador():
    """
    Abre o navegador e acessa o site da SSP.

    :return: Navegador aberto.
    """
    opcoes = Options()
    opcoes.add_argument('--headless') # Rodar sem abrir o navegador
    # opcoes.add_argument('--auto-open-devtools-for-tabs') # Abrir o console do navegador
    # opcoes.add_argument('--start-maximized')
    opcoes.add_experimental_option('prefs', {'download.default_directory': DIRETORIO_DOWNLOAD})
    navegador = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()), options=opcoes)
    navegador.set_page_load_timeout(1200)
    navegador.get('https://www.ssp.sp.gov.br/transparenciassp/Consulta.aspx')
    return navegador

def clicar(botao, valor=''):
    """
    Clica em um botão da página.

    :param botao: Tipo do botão.
    :param valor: Valor do botão. (opcional)
    """
    elemento = (By.XPATH, f'//*[@id="{BOTOES[botao]}{valor}"]')
    WebDriverWait(navegador, 30).until(EC.element_to_be_clickable(elemento)).click()

def verificar_periodo():
    """
    Verifica se o período selecionado tem arquivos disponíveis.

    :return: True se o período tem arquivos disponíveis, False caso contrário.
    """
    try:
        elemento = (By.XPATH, '//*[@id="cphBody_lblMsg"]')
        WebDriverWait(navegador, 5).until(EC.presence_of_element_located(elemento))
        return False
    except:
        return True


# Inicio do programa
# Cria as categorias dos arquivos que serão baixados, e define o navegador que será usado para a raspagem.
# Itera sobre as categorias, verificando os arquivos pendentes de download, e os baixa.
# Após o download, move os arquivos para a pasta de destino e atualiza o arquivo de controle.

criar_categoria(categoria='FurtoCelular', expressao='^DadosBO_(\d{4})_(\d{1,2})\(FURTO DE CELULAR\)\.xls$')
criar_categoria(categoria='RouboCelular', expressao='^DadosBO_(\d{4})_(\d{1,2})\(ROUBO DE CELULAR\)\.xls$')
pendentes = arquivos_pendentes()

navegador = abrir_navegador()
print('Acessando site...')
for categoria in pendentes:
    clicar('categoria', categoria)
    for ano in pendentes[categoria]["arquivos"]:
        clicar('ano', ano % 100)
        for mes in pendentes[categoria]["arquivos"][ano]:
            clicar('mes', mes)

            if verificar_periodo() == False:
                print(f'Não há registros para {categoria} no período {ano}-{mes}!')
                continue

            try:
                print(f'Exportando {categoria}, {ano}-{mes}...')
                clicar('exportar')

                expressao = pendentes[categoria]["expressao"]
                for i in range(0, 30):
                    arquivos = os.listdir(DIRETORIO_DOWNLOAD)
                    coincide = [arquivo for arquivo in arquivos if re.match(expressao, arquivo)]

                    if coincide:
                        break
                    print('Aguardando arquivo baixar...')
                    time.sleep(5)

                for arquivo in coincide:
                    sucesso = adicionar_arquivo(categoria, arquivo)
                    if sucesso:
                        print(f'Arquivo {arquivo} baixado com sucesso!')
            except Exception as e:
                 print(f'Erro ao baixar arquivo para {categoria} no período {ano}-{mes}!\nErro: {e}')

print('Fechando navegador...')
navegador.quit()
