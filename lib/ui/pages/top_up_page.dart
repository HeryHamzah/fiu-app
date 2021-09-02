part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  TopUpPage(this.pageEvent);
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController();

  List<int> template = [
    50000,
    100000,
    200000,
    250000,
    500000,
    1000000,
    2000000,
    2500000,
    5000000
  ];

  int selectedTemplate = 0;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(
        text: NumberFormat.currency(
                locale: 'id_ID', decimalDigits: 0, symbol: 'IDR ')
            .format(selectedTemplate));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        backgroundColor: backColor,
        body: Container(
          margin: EdgeInsets.fromLTRB(
              defaultMargin, 20, defaultMargin, defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Stack(
                      children: [
                        InkWell(
                            onTap: () {
                              context.bloc<PageBloc>().add(widget.pageEvent);
                            },
                            child: Icon(Icons.arrow_back_ios,
                                color: Colors.white)),
                        Center(
                            child: Text("Top Up",
                                style: themeFont.copyWith(fontSize: 18)))
                      ],
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    style: TextStyle(color: Colors.grey),
                    controller: amountController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        hintText: "Amount",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Choose by Template",
                        style: themeFont.copyWith(fontSize: 16)),
                  ),
                  SizedBox(height: 14),
                  Wrap(
                      spacing: 24,
                      runSpacing: 16,
                      children: List.generate(
                          template.length,
                          (index) => TopUpCard(
                                amount: template[index],
                                width: (MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        2 * 24) /
                                    3,
                                isSelected: template[index] == selectedTemplate,
                                onTap: () {
                                  if (template[index] == selectedTemplate) {
                                    selectedTemplate = 0;
                                  } else {
                                    selectedTemplate = template[index];
                                  }
                                  amountController.text = NumberFormat.currency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                          symbol: 'IDR ')
                                      .format(selectedTemplate);

                                  setState(() {});
                                },
                              ))),
                  SizedBox(height: 100),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) {
                      return Container(
                        width: 250,
                        height: 46,
                        child: MaterialButton(
                          disabledColor: Color(0XFFE4E4E4).withOpacity(.1),
                          color: secondColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text("Top Up Now",
                              style: themeFont.copyWith(
                                  color: (selectedTemplate > 0)
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 16)),
                          onPressed: (selectedTemplate > 0)
                              ? () {
                                  FiuTransaction transaction = FiuTransaction(
                                      userID: (userState as UserLoaded).user.id,
                                      title: "Top Up Wallet",
                                      amount: selectedTemplate,
                                      desc: DateTime.now().dayAndDate,
                                      time: DateTime.now());

                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToSuccesTopUpPage(transaction));
                                }
                              : null,
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
