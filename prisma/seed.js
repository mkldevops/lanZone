const { PrismaClient } = require("@prisma/client");
const bcrypt = require("bcrypt");
const prisma = new PrismaClient();

async function main() {
  // Nettoyage des données existantes
  await prisma.$transaction([
    prisma.badgeUtilisateur.deleteMany(),
    prisma.participant.deleteMany(),
    prisma.materielUtilisateur.deleteMany(),
    prisma.lan.deleteMany(),
    prisma.badge.deleteMany(),
    prisma.materiel.deleteMany(),
    prisma.utilisateur.deleteMany(),
  ]);

  // Hachage du mot de passe
  const saltRounds = 10;
  const hashedPassword = await bcrypt.hash("password123", saltRounds);

  // Création d'utilisateurs
  await prisma.utilisateur.createMany({
    data: [
      {
        nom: "Dupont",
        prenom: "Jean",
        date_naissance: new Date("1990-01-15"),
        mail: "jean.dupont@example.com",
        pseudo: "jeandupont",
        password: hashedPassword,
        role: "utilisateur",
      },
      {
        nom: "Martin",
        prenom: "Sophie",
        date_naissance: new Date("1992-05-20"),
        mail: "sophie.martin@example.com",
        pseudo: "sophiemartin",
        password: hashedPassword,
        role: "utilisateur",
      },
    ],
    skipDuplicates: true, // Évite les erreurs si les emails existent déjà
  });

  console.log("Utilisateurs créés avec succès !");

  await prisma.badge.createMany({
    data: [
      {
        nom_badge: "Nouvelle recrue",
        description: "A participé à sa première LAN",
        date_obtention: new Date(),
      },
      {
        nom_badge: "Habitué",
        description: "A participé à 5 LANs",
        date_obtention: new Date(),
      },
      {
        nom_badge: "Légende",
        description: "A participé à 10 LANs",
        date_obtention: new Date(),
      },
    ],
    skipDuplicates: true,
  });

  console.log("Badges ajoutés avec succès !");

  // Récupération d'un utilisateur existant
  const utilisateurs = await prisma.utilisateur.findMany(); // Assurez-vous qu'il y a au moins un utilisateur dans la base de données

  if (!utilisateurs) {
    console.log("Aucun utilisateur trouvé. Créez un utilisateur d'abord !");
    return;
  }

  const badges = await prisma.badge.findMany();

  // Attribution des badges aux utilisateurs
  for (const utilisateur of utilisateurs) {
    await prisma.badgeUtilisateur.createMany({
      data: [
        { utilisateur_id: utilisateur.id, badge_id: badges[0].id }, // On attribue le badge "Nouvelle recrue"
        { utilisateur_id: utilisateur.id, badge_id: badges[1].id }, // On attribue le badge "Habitué"
        { utilisateur_id: utilisateur.id, badge_id: badges[2].id }, // On attribue le badge "Légende"
      ],
    });
    console.log(`Badges attribués à l'utilisateur ID ${utilisateur.id} !`);
  }
}

main()
  .catch((e) => console.error(e))
  .finally(async () => await prisma.$disconnect());
