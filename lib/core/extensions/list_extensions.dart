extension SeparatedList<T> on List<T> {
  List<T> insertBetween(T separator) {
    if (length <= 1) return this;
    return [
      for (int i = 0; i < length; i++) ...[
        this[i],
        if (i != length - 1) separator,
      ]
    ];
  }
}
