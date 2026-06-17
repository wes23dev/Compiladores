import java.io.*;
import erros.ListaErros;

class Main {
    public static void main(String[] args) throws Exception {
        if (args.length < 1) {
            System.err.println("Uso: java Main <arquivo.mj>");
            System.exit(1);
        }

        String nomeArquivo = args[0];
        ListaErros listaErros = new ListaErros();

        FileReader in;
        try {
            in = new FileReader(nomeArquivo);
        } catch (FileNotFoundException e) {
            System.err.println("Erro: arquivo não encontrado: " + nomeArquivo);
            System.exit(1);
            return;
        }

        scanner.Scanner scanner = new scanner.Scanner(in, listaErros);
        parser.parser parser = new parser.parser(scanner);
        parser.setListaErros(listaErros);

        try {
            parser.parse();
        } catch (Exception e) {
            // erros ja registrados na lista
        }

        if (listaErros.hasErros()) {
            System.out.println("Erros encontrados em: " + nomeArquivo);
            listaErros.dump();
        } else {
            System.out.println("Programa aceito sem erros: " + nomeArquivo);
        }
    }
}
