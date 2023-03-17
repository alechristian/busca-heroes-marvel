import 'package:code_hero_project/app/pages/home/home_controller.dart';
import 'package:code_hero_project/utils/enums/model_state.dart';
import 'package:flutter/material.dart';
import 'package:code_hero_project/const/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final controller = HomeController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var heightTela = MediaQuery.of(context).size.height;
    var widthTela = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryRed,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.primaryWhite,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: 'busca marvel'.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primaryRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'teste front-end'.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ],
          )),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Column(
          children: [
            Container(
              height: 70,
              decoration: const BoxDecoration(color: AppColors.primaryWhite),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          "Nome do Personagem",
                          style: TextStyle(
                              color: AppColors.primaryRed, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    width: 320,
                    child: TextFormField(
                      onChanged: (value) {
                        controller.buscaPersonagemLista();
                      },
                      controller: controller.nomePersonagemBuscar,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: AppColors.primaryBlack),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Text(
                      "Nome",
                      style: TextStyle(
                          color: AppColors.primaryWhite, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: heightTela * 0.60,
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  controller.state == modelState.loading
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryWhite,
                        )
                      : controller.buscaPersonagensRetorno?.data.results == null
                          ? Container()
                          : controller.personagensFiltrados.isEmpty
                              ? const CircularProgressIndicator()
                              : Expanded(
                                  child: ListView.builder(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller
                                          .getPersonagensPagina(
                                              controller.paginaAtual)
                                          ?.length,
                                      // itemCount: 4,
                                      itemBuilder: (context, index) {
                                        final personagem =
                                            controller.getPersonagensPagina(
                                                controller.paginaAtual)?[index];
                                        return ListTile(
                                          title: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryWhite,
                                              border: Border.all(
                                                width: 10,
                                                color: AppColors.primaryWhite,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    child: Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image.network(
                                                          '${personagem?.thumbnailUrl}'),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Container(
                                                    width: widthTela * 0.6,
                                                    child: Text(
                                                      "${personagem?.name}",
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: AppColors
                                                              .primaryBlack),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                ]),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: BottomNavigationBar(
                elevation: 0.0,
                iconSize: 60,
                selectedItemColor: null,
                currentIndex: controller.paginaAtual,
                onTap: (index) {
                  if (index == 0) {
                    controller.setPaginaAtual(controller.paginaAtual - 1);
                  } else if (index == 4) {
                    controller.setPaginaAtual(controller.paginaAtual + 1);
                  }
                },
                unselectedItemColor: AppColors.primaryRed,
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_left_outlined),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          color: AppColors.primaryRed,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${controller.paginaAtual}'),
                            ],
                          )),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          color: AppColors.primaryRed,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${controller.paginaAtual + 1}'),
                            ],
                          )),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          color: AppColors.primaryRed,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${controller.paginaAtual + 2}'),
                            ],
                          )),
                    ),
                    label: '',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_right_sharp),
                    label: '',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    controller
        .buscaPersonagens()
        ?.whenComplete(() => controller.buscaPersonagemLista());
    super.initState();
  }
}
