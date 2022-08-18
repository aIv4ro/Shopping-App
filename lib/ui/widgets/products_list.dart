import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_event.dart';
import 'package:shopping/blocs/products_list/products_list_state.dart';
import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/domain/repositories/dio/dio_product_repository.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key, required this.productBuilder});

  final Widget Function(Product product) productBuilder;

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  late final ProductsListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ProductsListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsListBloc, ProductsListState>(
      builder: (context, state) {
        final products = state.productsFilter;
        final productsLength = products.length;
        final hasReachedMax = state.hasReachedMax;
        final isLoadingPage = state.status != ProductsListStatus.loadingPage;

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
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

            final product = products[index];

            return widget.productBuilder(product);
          },
        );
      },
    );
  }
}
