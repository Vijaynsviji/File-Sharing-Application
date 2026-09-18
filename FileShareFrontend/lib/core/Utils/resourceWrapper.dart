

sealed class Resource<T> {
  const Resource();
}

// Success State
class ResourceSuccess<T> extends Resource<T> {
  final T data;
  const ResourceSuccess(this.data);
}

// Failure State
class ResourceFailure<T> extends Resource<T> {
  final String errorMessage;
  final Exception? exception; // Optional for debugging
  const ResourceFailure(this.errorMessage, {this.exception});
}
