// class PaymentCard {
//   int? issuer;
//
//   String? number;
//
//   String? name;
//
//   String? month;
//
//   String? year;
//
//   String? cvv;
//
//   String? id;
//
//   PaymentCard();
//
//   setIssuer(CardIssuer value) {
//     if (value == CardIssuer.master) {
//       issuer = 0;
//     } else if (value == CardIssuer.visa) {
//       issuer = 1;
//     } else if (value == CardIssuer.verve) {
//       issuer = 2;
//     } else {
//       issuer = 3;
//     }
//   }
//
//   setIssuer2(String value) {
//     if (value == "MASTER") {
//       issuer = 0;
//     } else if (value == "VISA") {
//       issuer = 1;
//     } else if (value == "MAESTRO") {
//       issuer = 2;
//     } else {
//       issuer = 3;
//     }
//   }
//
//   static int convertIssuer(CardIssuer value) {
//     if (value == CardIssuer.master) {
//       return 0;
//     } else if (value == CardIssuer.visa) {
//       return 1;
//     } else if (value == CardIssuer.verve) {
//       return 2;
//     } else {
//       return 3;
//     }
//   }
//
//   CardIssuer getIssuer() {
//     if (issuer == 0) {
//       return CardIssuer.master;
//     } else if (issuer == 1) {
//       return CardIssuer.visa;
//     } else if (issuer == 2) {
//       return CardIssuer.verve;
//     } else {
//       return CardIssuer.unknown;
//     }
//   }
//
//   PaymentCard.dummy(
//       {this.issuer = 3,
//       this.number = '340000000000009',
//       this.name = 'Wilberforce Uwadiegwu',
//       this.month = '12',
//       this.year = '02',
//       this.cvv = '123',
//       this.id = "1"});
//
//   factory PaymentCard.fromJson(Map<String, dynamic> json) {
//     PaymentCard card = PaymentCard.dummy(
//         name: "Test User",
//         number: "************${json['last4']}",
//         month: json['exp_month'].toString(),
//         year: json['exp_year'].toString(),
//         cvv: "123",
//         id: json['id'].toString());
//     card.setIssuer2(json['card_type']);
//     return card;
//     ;
//   }
//
//   Map<String, dynamic> toJson() => {
//         "card_name": name,
//         "card_number": number,
//         "exp_month": month,
//         "exp_year": year,
//         "cvv": cvv,
//       };
// }
//
