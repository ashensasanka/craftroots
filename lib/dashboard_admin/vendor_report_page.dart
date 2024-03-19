import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../model/customer.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import '../widget/button_widget.dart';
import '../widget/pdf_helper.dart';
import '../widget/pdf_invoice_helper.dart';
import '../widget/title_widget.dart';

class VendorReportPage extends StatefulWidget {
  final String name;
  const VendorReportPage({Key? key, required this.name}) : super(key: key);

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<VendorReportPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color.fromARGB(66, 196, 194, 194),
    appBar: AppBar(
      title: Text('${widget.name} Report'),
      centerTitle: true,
    ),
    body: Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleWidget(
              icon: Icons.picture_as_pdf,
              text: 'Generate Vendor Report',
            ),
            const SizedBox(height: 48),
            ButtonWidget(
              text: 'Get PDF',
              onClicked: () async {
                final date = DateTime.now();
                final dueDate = date.add(
                  const Duration(days: 7),
                );
                final invoice = Invoice(
                  supplier: Supplier(
                    name: widget.name,
                    address: 'Dhaka, Bangladesh',
                    paymentInfo: 'https://paypal.me/codespec',
                  ),
                  customer: const Customer(
                    name: 'Google',
                    address: 'Mountain View, California, United States',
                  ),
                  info: InvoiceInfo(
                    date: date,
                    dueDate: dueDate,
                    description: 'First Order Invoice',
                    number: '${DateTime.now().year}-9999',
                  ),
                  items: [
                    InvoiceItem(
                      description: '12349202',
                      date: DateTime.now(),
                      quantity: 3,
                      vat: 0.19,
                      unitPrice: 5.99,
                    ),
                    InvoiceItem(
                      description: '56781222',
                      date: DateTime.now(),
                      quantity: 8,
                      vat: 0.19,
                      unitPrice: 0.99,
                    ),
                    InvoiceItem(
                      description: '91013242',
                      date: DateTime.now(),
                      quantity: 3,
                      vat: 0.19,
                      unitPrice: 2.99,
                    ),
                    InvoiceItem(
                      description: '11215262',
                      date: DateTime.now(),
                      quantity: 8,
                      vat: 0.19,
                      unitPrice: 3.99,
                    ),
                    InvoiceItem(
                      description: '31417282',
                      date: DateTime.now(),
                      quantity: 1,
                      vat: 0.19,
                      unitPrice: 1.59,
                    ),
                    InvoiceItem(
                      description: '51619303',
                      date: DateTime.now(),
                      quantity: 5,
                      vat: 0.19,
                      unitPrice: 0.99,
                    ),
                    InvoiceItem(
                      description: '71811323',
                      date: DateTime.now(),
                      quantity: 4,
                      vat: 0.19,
                      unitPrice: 1.29,
                    ),
                  ],
                );
                final pdfFile = await PdfInvoicePdfHelper.generatevendor(invoice);
                PdfHelper.openFile(pdfFile);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Vendor Report Generated !'),
                    content: Text('PDF file has been generated successfully.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          PdfHelper.openFile(pdfFile); // Pass BuildContext
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

// data/user/0/com.example.craftroots/app_flutter/my_invoice.pdf
