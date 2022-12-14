import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_event.dart';
import 'package:shopping/blocs/products_bloc/products_state.dart';
import 'package:shopping/ui/pages/products/widgets/create_product_popup.dart';
import 'package:shopping/ui/pages/products/widgets/product_item.dart';
import 'package:shopping/ui/widgets/search_bar.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductsPage> {
  late final ProductsBloc _bloc;

  @override
  void initState() {
    _bloc = context.read();
    super.initState();
  }

  void _showSnackbarMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _onFilterChanged(String? value) {
    _bloc.add(FilterProductsEvent(newFilterValue: value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        title: 'Products',
        onFilterChanged: _onFilterChanged,
      ),
      body: BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state.status == ProductsStatus.productDeleted) {
            _showSnackbarMessage(message: 'Product deleted');
          }

          if (state.status == ProductsStatus.productDeletionError) {
            _showSnackbarMessage(message: 'Could not delete product');
          }

          if (state.status == ProductsStatus.productUpdated) {
            Navigator.of(context).pop();
            _showSnackbarMessage(message: 'Product updated');
          }

          if (state.status == ProductsStatus.productUpdateError) {
            Navigator.of(context).pop();
            _showSnackbarMessage(message: 'Could not update product');
          }

          if (state.status == ProductsStatus.productCreated) {
            Navigator.of(context).pop();
            _showSnackbarMessage(message: 'Product created');
          }

          if (state.status == ProductsStatus.productCreationError) {
            Navigator.of(context).pop();
            _showSnackbarMessage(message: 'Could not create product');
          }
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            final products = state.filteredProducts;
            final productsLength = products.length;
            final hasReachedMax = state.hasReachedMax;
            final isLoadingPage = state.status != ProductsStatus.loadingPage;

            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                );
              },
              itemCount: hasReachedMax ? productsLength : productsLength + 1,
              itemBuilder: (context, index) {
                final isLastItem = index == productsLength;

                if (isLastItem && isLoadingPage && !hasReachedMax) {
                  _bloc.add(const LoadNextPageEvent());
                }

                if (isLastItem) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ProductItem(
                  product: products[index],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: _bloc,
                child: const CreateProductPopup(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
