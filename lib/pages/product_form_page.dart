import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:provider/provider.dart';
import '../models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Salva o estado do formulário
  final _formData = Map<String, Object>(); // Guarda dados do formulário

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  //Metodo dispose: libera recursos após tela liberada
  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {}); // Atualiza o fomulário mostrando imagem da URL
  }

  //Verifica validação da url
  //Uri.tryParse = posssivel validar url? hasAbsolutePath = caminho absoluto
  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false; //Señ = falso
    //Padroniza em letras minúsculas e verifica extenção da imagem
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    // validate: valida formulário. Como currentState? é opcional, se ñ = falso
    final isValid = _formKey.currentState?.validate() ?? false;

    //Se falso retorna e não executa o metodo p/ submeter formulário
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save(); // currentState"?": se disponível e salva

    Provider.of<ProductList>(
      context,
      listen: false,
    ).addProductFromData(_formData);
    Navigator.of(context).pop(); // Volta para tela anterior após add produto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '', // ??: Senão
                validator: (_name) {
                  final name = _name ?? '';

                  //trim = retira os espaços em branco, isEmpty = é vazio
                  if (name.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }

                  //length < 3 = mínimo de 3 letras
                  if (name.trim().length < 3) {
                    return 'Nome precisa no mínimo de 3 letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (price) => _formData['price'] =
                    double.parse(price ?? '0'), // ??: Senão campo recebe 0
                validator: (_price) {
                  final priceString = _price ?? '';
                  final price = double.tryParse(priceString) ?? -1;

                  if (price <= 0) {
                    return 'Informe um preço válido!';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['description'] = description ?? '', // ??: Senão
                validator: (_description) {
                  final description = _description ?? '';

                  //trim = retira os espaços em branco, isEmpty = é vazio
                  if (description.trim().isEmpty) {
                    return 'Descrição é obrigatória!';
                  }

                  //length < 3 = mínimo de 3 letras
                  if (description.trim().length < 10) {
                    return 'Descrição precisa no mínimo de 10 letras!';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da Imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction:
                          TextInputAction.done, // Submete no enter.
                      focusNode: _imageUrlFocus,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '', // ??: Senão
                      validator: (_imageUrl) {
                        final imageUrl = _imageUrl ?? '';
                        if (!isValidImageUrl(imageUrl)) {
                          return 'Informe uma URL válida!';
                        }

                        //Se válido retorna nulo, ou seja, url válida
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty // Se vasio
                        ? Text('Informe a URL') // Se verdadeiro. Mostra o texto
                        : FittedBox(
                            // Senão. Mostra Imagem
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//URL de Teste:
//https://cdn.pixabay.com/photo/2013/07/13/10/51/football-157930_960_720.png