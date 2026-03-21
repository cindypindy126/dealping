class AppConstants {
  AppConstants._();

  static const String appName = 'Dealping';
  static const String appVersion = '1.0.0';

  // Firestore collections
  static const String colBenefitProviders = 'benefit_providers';
  static const String colCategories = 'categories';
  static const String colMerchants = 'merchants';
  static const String colUsers = 'users';
  static const String subcolBenefits = 'benefits';
  static const String subcolTiers = 'tiers';
  static const String subcolMyProviders = 'my_providers';

  // Provider types
  static const String typeCard = 'card';
  static const String typeTelecom = 'telecom';

  // Card types
  static const String typeCredit = 'credit';
  static const String typeDebit = 'debit';

  // Benefit types
  static const String benefitDiscount = 'discount';
  static const String benefitCashback = 'cashback';
  static const String benefitPoint = 'point';
}
