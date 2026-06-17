package erros;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ListaErros {

    private List<Erro> erros;

    public ListaErros() {
        erros = new ArrayList<>();
    }

    public void addErro(Erro erro) {
        erros.add(erro);
    }

    public void addErro(int linha, int coluna, String mensagem) {
        erros.add(new Erro(linha, coluna, mensagem));
    }

    public boolean hasErros() {
        return !erros.isEmpty();
    }

    public int getTotal() {
        return erros.size();
    }

    public List<Erro> getErros() {
        return Collections.unmodifiableList(erros);
    }

    public void dump() {
        for (Erro erro : erros) {
            System.out.println(erro);
        }
        System.out.println("Total de erros: " + erros.size());
    }
}
