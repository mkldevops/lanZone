-- CreateTable
CREATE TABLE "Badge" (
    "id" SERIAL NOT NULL,
    "nom_badge" TEXT NOT NULL,
    "image_url" TEXT NOT NULL DEFAULT '/images/badges/default.png',
    "description" TEXT NOT NULL,
    "date_obtention" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Badge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BadgeUtilisateur" (
    "utilisateur_id" INTEGER NOT NULL,
    "badge_id" INTEGER NOT NULL,

    CONSTRAINT "BadgeUtilisateur_pkey" PRIMARY KEY ("utilisateur_id","badge_id")
);

-- CreateTable
CREATE TABLE "Lan" (
    "id" SERIAL NOT NULL,
    "nom_lan" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "lieu" TEXT NOT NULL,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "description" TEXT NOT NULL,
    "organisateur_id" INTEGER NOT NULL,
    "max_participants" INTEGER NOT NULL DEFAULT 10,
    "materiel" TEXT NOT NULL,

    CONSTRAINT "Lan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Materiel" (
    "id" SERIAL NOT NULL,
    "nom_materiel" TEXT NOT NULL,

    CONSTRAINT "Materiel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MaterielUtilisateur" (
    "id" SERIAL NOT NULL,
    "utilisateur_id" INTEGER NOT NULL,
    "materiel_id" INTEGER NOT NULL,
    "quantite" INTEGER NOT NULL,

    CONSTRAINT "MaterielUtilisateur_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Participant" (
    "id" SERIAL NOT NULL,
    "utilisateur_id" INTEGER NOT NULL,
    "lan_id" INTEGER NOT NULL,
    "date_inscription" TIMESTAMP(3) NOT NULL,
    "rang" INTEGER,

    CONSTRAINT "Participant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Utilisateur" (
    "id" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "prenom" TEXT NOT NULL,
    "date_naissance" TIMESTAMP(3) NOT NULL,
    "mail" TEXT NOT NULL,
    "pseudo" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL,

    CONSTRAINT "Utilisateur_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Utilisateur_mail_key" ON "Utilisateur"("mail");

-- CreateIndex
CREATE UNIQUE INDEX "Utilisateur_pseudo_key" ON "Utilisateur"("pseudo");

-- AddForeignKey
ALTER TABLE "BadgeUtilisateur" ADD CONSTRAINT "BadgeUtilisateur_utilisateur_id_fkey" FOREIGN KEY ("utilisateur_id") REFERENCES "Utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BadgeUtilisateur" ADD CONSTRAINT "BadgeUtilisateur_badge_id_fkey" FOREIGN KEY ("badge_id") REFERENCES "Badge"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Lan" ADD CONSTRAINT "Lan_organisateur_id_fkey" FOREIGN KEY ("organisateur_id") REFERENCES "Utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaterielUtilisateur" ADD CONSTRAINT "MaterielUtilisateur_utilisateur_id_fkey" FOREIGN KEY ("utilisateur_id") REFERENCES "Utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaterielUtilisateur" ADD CONSTRAINT "MaterielUtilisateur_materiel_id_fkey" FOREIGN KEY ("materiel_id") REFERENCES "Materiel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Participant" ADD CONSTRAINT "Participant_utilisateur_id_fkey" FOREIGN KEY ("utilisateur_id") REFERENCES "Utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Participant" ADD CONSTRAINT "Participant_lan_id_fkey" FOREIGN KEY ("lan_id") REFERENCES "Lan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
