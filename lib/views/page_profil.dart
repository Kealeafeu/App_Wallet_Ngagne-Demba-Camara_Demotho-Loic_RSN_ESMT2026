import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_wallet/view_models/user_view_model.dart';
import 'package:app_wallet/views/page_accueil.dart';

class PageProfil extends StatefulWidget {
  const PageProfil({super.key});

  @override
  State<PageProfil> createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userVM = Provider.of<UserViewModel>(context, listen: false);
      userVM.loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<UserViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profil Utilisateur")),
      body: userVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userVM.users.isEmpty
              ? const Center(child: Text("Aucun utilisateur trouvé"))
              : ListView.builder(
                  itemCount: userVM.users.length,
                  itemBuilder: (context, index) {
                    final user = userVM.users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Navigation vers PageAccueil avec userId
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PageAccueil(userId: user.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}