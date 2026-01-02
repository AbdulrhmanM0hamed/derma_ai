import 'package:equatable/equatable.dart';
import '../../data/models/package_model.dart';
import '../../data/models/package_feature_model.dart';
import '../../data/models/package_comparison_model.dart';

abstract class PackagesState extends Equatable {
  const PackagesState();

  @override
  List<Object?> get props => [];
}

// Initial State
class PackagesInitial extends PackagesState {}

// Loading State
class PackagesLoading extends PackagesState {}

// Loaded State
class PackagesLoaded extends PackagesState {
  final List<PackageModel> packages;
  final List<PackageFeatureModel> features;

  const PackagesLoaded({required this.packages, required this.features});

  @override
  List<Object?> get props => [packages, features];
}

// Error State
class PackagesError extends PackagesState {
  final String message;

  const PackagesError(this.message);

  @override
  List<Object?> get props => [message];
}

// Package Detail Loading State
class PackageDetailLoading extends PackagesState {}

// Package Detail Loaded State
class PackageDetailLoaded extends PackagesState {
  final PackageModel package;

  const PackageDetailLoaded(this.package);

  @override
  List<Object?> get props => [package];
}

// Package Detail Error State
class PackageDetailError extends PackagesState {
  final String message;

  const PackageDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

// Comparison Loading State
class PackagesComparisonLoading extends PackagesState {}

// Comparison Loaded State
class PackagesComparisonLoaded extends PackagesState {
  final PackageComparisonModel comparison;

  const PackagesComparisonLoaded(this.comparison);

  @override
  List<Object?> get props => [comparison];
}

// Comparison Error State
class PackagesComparisonError extends PackagesState {
  final String message;

  const PackagesComparisonError(this.message);

  @override
  List<Object?> get props => [message];
}
