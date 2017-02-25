

distSurfaceBordHaut = 24; //distance entre bord haut du verre et surface de l'eau
epaisseurVerre = 6;

epaisseurVerreBis = epaisseurVerre + 0.5;
epaisseurParoi = 3;
hauteurPatteExterieure = 30;
hauteur = epaisseurParoi + distSurfaceBordHaut + 50;
largeur = 30;
epaisseurFixation = 10;
hauteurFixation = 13;
epaisseurTotale = epaisseurVerreBis + epaisseurFixation + 2*epaisseurParoi;
largeurOuvertureFixationFace = 24;
hauteurOuvertureFixationFace = 7;
sphereD = 5;

module skimmer() {
  difference() {
    // Corps
    cube([largeur, epaisseurTotale, hauteur]);
    // Evidement central
    translate([-0.5, epaisseurFixation + epaisseurParoi, -epaisseurParoi])
      cube([largeur + 1, epaisseurVerreBis , hauteur]);
    // Carcourcir patte exterieure
    translate([-0.5, epaisseurFixation + 3*epaisseurParoi, -1])
      cube([largeur + 1, epaisseurVerreBis, hauteur - hauteurPatteExterieure +1]);    
    // Retrait au dessus fixation
    translate([-0.5, -1, hauteurFixation])
      cube([largeur + 1, epaisseurFixation + 1, hauteur ]);
    // Retrait moindre pour avancée anti capillarité
    translate([-0.5, -1, hauteurFixation])
      cube([largeur + 1, epaisseurFixation/2, hauteur]);   
    
    // Ouverture fixation face
    translate([(largeur - largeurOuvertureFixationFace)/2, -1, (hauteurFixation - hauteurOuvertureFixationFace)/2])
      cube([largeurOuvertureFixationFace, epaisseurFixation + 1, hauteurOuvertureFixationFace]);
  
    // Ouverture fixation dessous
    translate([(largeur - largeurOuvertureFixationFace)/2, 3, -(hauteurOuvertureFixationFace/2)])
      cube([largeurOuvertureFixationFace, epaisseurFixation - 2*epaisseurParoi, hauteurOuvertureFixationFace]);    
  }
  translate([0, epaisseurFixation - (sphereD/2), hauteurFixation/2])	
    antiCapilarite();	
  
}

module antiCapilarite() {
	difference() {		
	  // Add spheres to not allow water to climb because of capilarity.
		for(i = [1:1:hauteur/(2*sphereD)]) {
			translate([(largeur - sphereD)/4, sphereD/2 + 1.3, i*2*sphereD - 10])
				sphere(d = sphereD , $fn=20);
			translate([largeur - (largeur - sphereD)/4, sphereD/2 + 1.3 , i*2*sphereD - 10])
				sphere(d = sphereD , $fn=20);
		}
		translate([0, sphereD/4, -sphereD])
	    cube([largeur, sphereD/2, hauteur]);
	}	
}

skimmer();
//antiCapilarite();