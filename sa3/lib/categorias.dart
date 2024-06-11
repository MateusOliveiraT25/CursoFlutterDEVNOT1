// Enumeração que representa as categorias dos itens da lista de compras
enum Categoria { // enum: um conjunto de valores nomeados
  Frutas,
  Vegetais,
  Carnes,
  Laticinios,
  Limpeza,
  Bebidas,
  AlimentosBasicos,
  Lanches,
  Higiene,
  LimpezaCasa,
  Eletronicos,
  Vestuario,
  Papelaria,
  Automotivo,
  Petshop,
  Brinquedos,
  Decoracao,
  Outros,
}

// Extensão da enumeração Categoria para adicionar a propriedade "nome"
extension CategoriaExtension on Categoria {
  // Método getter para retornar o nome da categoria
  String get nome {
    switch (this) {
      case Categoria.Frutas:
        return 'Frutas';
      case Categoria.Vegetais:
        return 'Vegetais';
      case Categoria.Carnes:
        return 'Carnes';
      case Categoria.Laticinios:
        return 'Laticínios';
      case Categoria.Limpeza:
        return 'Limpeza';
      case Categoria.Bebidas:
        return 'Bebidas';
      case Categoria.AlimentosBasicos:
        return 'Alimentos Básicos';
      case Categoria.Lanches:
        return 'Lanches';
      case Categoria.Higiene:
        return 'Higiene';
      case Categoria.LimpezaCasa:
        return 'Limpeza Casa';
      case Categoria.Eletronicos:
        return 'Eletrônicos';
      case Categoria.Vestuario:
        return 'Vestuário';
      case Categoria.Papelaria:
        return 'Papelaria';
      case Categoria.Automotivo:
        return 'Automotivo';
      case Categoria.Petshop:
        return 'Petshop';
      case Categoria.Brinquedos:
        return 'Brinquedos';
      case Categoria.Decoracao:
        return 'Decoração';
      case Categoria.Outros:
        return 'Outros';
      default:
        return '';
    }
  }
}

