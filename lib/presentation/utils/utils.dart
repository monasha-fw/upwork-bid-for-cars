class Utils {
  static validateFieldError(fv, {required bool showErrors, required String errorMessage}) {
    /// only show each error messages on userInteractions,
    /// unless user press signup button (state.showErrors == true)
    return fv?.failedValue?.isEmpty && !showErrors ? null : errorMessage;
  }
}
