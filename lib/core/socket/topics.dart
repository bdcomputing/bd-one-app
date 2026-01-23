enum SocketIoTopics {
  paymentsSearch,
  invoiceSearch,
}

extension SocketIoTopicsExtension on SocketIoTopics {
  String get value {
    switch (this) {
      case SocketIoTopics.paymentsSearch:
        return 'paymentsSearch';
      case SocketIoTopics.invoiceSearch:
        return 'invoiceSearch';
    }
  }
}
