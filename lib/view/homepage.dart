import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechinetestforinfonix/controller/apiservice.dart';
import 'package:mechinetestforinfonix/controller/controller.dart';
import 'package:mechinetestforinfonix/model/datamodel.dart';
import 'package:mechinetestforinfonix/view/catagoriyone.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataModel>(
        future: apiService.getDataFromServer()!,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
           const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            DataModel dataModel = snapshot.data as DataModel;
            return DefaultTabController(
              length: 6,
              child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: dataModel.tableMenuList![0].menuCategory,
                      ),
                      Tab(
                        text: dataModel.tableMenuList![1].menuCategory,
                      ),
                      Tab(
                        text: dataModel.tableMenuList![2].menuCategory,
                      ),
                      Tab(
                        text: dataModel.tableMenuList![3].menuCategory,
                      ),
                      Tab(
                        text: dataModel.tableMenuList![4].menuCategory,
                      ),
                      Tab(
                        text: dataModel.tableMenuList![5].menuCategory,
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    CategoriOne(currentIndex: 0, dataModel: dataModel),
                    CategoriOne(currentIndex: 1, dataModel: dataModel),
                    CategoriOne(currentIndex: 2, dataModel: dataModel),
                    CategoriOne(currentIndex: 3, dataModel: dataModel),
                    CategoriOne(currentIndex: 4, dataModel: dataModel),
                    CategoriOne(currentIndex: 5, dataModel: dataModel)
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        }

        // body: ListView(
        //   children: [
        //     ListTile(
        //       title: GetBuilder<Controller>(
        //         builder: (controller) {
        //           return StreamBuilder(
        //             stream: FirebaseAuth.instance.authStateChanges(),
        //             builder: (context, snapshot) {
        //               if (snapshot.hasError) {
        //                 return const Text("Sorry Something went wrong");
        //               }
        //               if (snapshot.connectionState == ConnectionState.waiting) {
        //                 return const Center(child: CircularProgressIndicator());
        //               }
        //               final user = snapshot.data as User;
        //               return user.displayName == null
        //                   ? Text(user.phoneNumber!)
        //                   : Text(user.displayName!);
        //             },
        //           );
        //         },
        //       ),
        //     ),
        //     FutureBuilder<DataModel>(
        //       future: apiService.getDataFromServer()!,
        //       builder: (context, snapshot) {
        //         if (snapshot.hasData) {
        //           DataModel dataModel = snapshot.data as DataModel;return
        //           Text(dataModel.tableMenuList!.first.menuCategory!);
        //         }
        //         return Text("dsf");
        //       },
        //     )
        //   ],
        // ),
        );
  }

}
