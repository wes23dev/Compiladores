
import java.io.FileInputStream;


class Main {
    public static void main(String[] args)   
      throws Exception {
        //Para ler a entrada do teclado
        // scanner scanner = new scanner(System.in);
        
        //Para ler a entrada do arquivo  
        FileInputStream in = new FileInputStream("test_input.txt");
        Scanner scanner = new Scanner(in);
        
        parser parser = new parser(scanner);
        try {
            parser.parse();
            System.out.println("Arquivo sem erros de sintaxe!");
        } catch (Exception e) {
            System.out.println("Erro de sintaxe:" + e);
        }
    }
}
