import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _phanTramTip = 0;
  int _soNguoi = 1;
  double _tong = 0.0;

  tinhTongTienMoiNguoi(double tongTien, int tyLeTip, int slgNguoi){
    double soTienMoiNguoi = (tinhTongTip(tongTien, tyLeTip)+tongTien)/slgNguoi;
    return soTienMoiNguoi.toStringAsFixed(2);
  }
  tinhTongTip(double tongTien, int tyLeTip)
  {
    double tongTip = 0.0;
    if(tongTien > 0||tongTien!=null||tongTien.toString().isEmpty == false){
      tongTip = tongTien * (tyLeTip.toDouble()/100);
    }
    return tongTip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Per Person",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "\$${tinhTongTienMoiNguoi(_tong, _phanTramTip, _soNguoi)}",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.grey.shade200, style: BorderStyle.solid)),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        prefix: Text("Bill Amount: "),
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _tong = double.parse(value);
                      } catch (exception) {
                        _tong = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _soNguoi < 1 ? _soNguoi == 0 : _soNguoi--;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.purple.shade50,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                          Text("$_soNguoi",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _soNguoi++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.purple.shade50,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "\$${(tinhTongTip(_tong, _phanTramTip)).toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$_phanTramTip %",
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _phanTramTip.toDouble(),
                          onChanged: (double newVal) {
                            setState(() {
                              _phanTramTip = newVal.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
