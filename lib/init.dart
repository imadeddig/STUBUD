import 'package:cloud_firestore/cloud_firestore.dart';

void init() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference fields = firestore.collection('fields');

  const fieldsData = {
    "Computer Science": {
      "wilayas": ["Algiers", "Annaba", "souk-ahras"],
      "universities": {
        "Algiers": ["ENSIA", "USTHB", "ESI"],
        "Annaba": ["Badji Mokhtar University"],
        "Souk-Ahras": ["Moahmmed sherif messadia"]
      },
      "speciality": ["artificial intelligence", "informatique"]
    },
    "Architecture": {
      "wilayas": ["Algiers", "Oran", "Constantine", "Annaba", "Tizi Ouzou"],
      "universities": {
        "Algiers": ["University of Algiers 1"],
        "Oran": ["University of Oran 1", "USTO-MB"],
        "Constantine": ["Mentouri University"],
        "Annaba": ["Badji Mokhtar University"],
        "Tizi Ouzou": ["Mouloud Mammeri University"]
      },
      "speciality": [
        "Urban Planning",
        "Building Construction",
        "Interior Design",
        "Landscape Architecture",
        "Sustainable Architecture",
        "Architectural Design",
        "Urban Design",
        "Architectural Engineering"
      ]
    },
    "Science and Technology": {
      "wilayas": ["Algiers", "Oran", "Constantine", "Annaba"],
      "universities": {
        "Algiers": ["USTHB", "ENP"],
        "Oran": ["University of Oran 1", "USTO-MB"],
        "Constantine": ["Mentouri University"],
        "Annaba": ["Badji Mokhtar University"]
      },
      "specialities": [
        "Computer Science",
        "Electronics",
        "Mechanical Engineering",
        "Civil Engineering"
      ]
    },
    "Health Sciences": {
      "wilayas": ["Algiers", "Oran", "Setif", "Blida", "Annaba", "Constantine"],
      "universities": {
        "Algiers": ["Faculty of Medicine, Algiers"],
        "Oran": ["Faculty of Medicine, Oran"],
        "Setif": ["Setif 1 University"],
        "Blida": ["Saad Dahlab University"],
        "Annaba": ["Badji Mokhtar University"],
        "Constantine": ["Mentouri University"],
      },
      "specialities": ["Medicine", "Pharmacy", "Dentistry", "Public Health"]
    },
    "Law and Political Science": {
      "wilayas": ["Algiers", "Bejaia", "Tizi Ouzou"],
      "universities": {
        "Algiers": ["University of Algiers 1"],
        "Bejaia": ["Abderrahmane Mira University"],
        "Tizi Ouzou": ["Mouloud Mammeri University"]
      },
      "specialities": ["Law", "Political Science", "Human Rights"]
    },
    "Natural and Life Sciences": {
      "wilayas": ["Batna", "Oran", "Tlemcen", "Skikda"],
      "universities": {
        "Batna": ["Batna 1 University"],
        "Oran": ["University of Science and Technology Oran"],
        "Tlemcen": ["Abou Bekr Belkaid University"],
        "Skikda": ["20 August 1955 University"]
      },
      "specialities": [
        "Biology",
        "Biotechnology",
        "Ecology",
        "Environmental Sciences"
      ]
    },
    "Economics and Management": {
      "wilayas": ["Algiers", "Blida", "Tizi Ouzou", "Bejaia"],
      "universities": {
        "Algiers": ["University of Algiers 3"],
        "Blida": ["Saad Dahlab University"],
        "Tizi Ouzou": ["Mouloud Mammeri University"],
        "Bejaia": ["Abderrahmane Mira University"]
      },
      "specialities": [
        "Finance",
        "Accounting",
        "Marketing",
        "Business Administration"
      ]
    },
    "Education and Pedagogy": {
      "wilayas": ["Constantine", "Oran", "Setif", "Annaba"],
      "universities": {
        "Constantine": ["Constantine 2 University"],
        "Oran": ["Oran Higher Normal School"],
        "Setif": ["Setif 2 University"],
        "Annaba": ["Badji Mokhtar University"]
      },
      "specialities": [
        "Educational Sciences",
        "Physical Education",
        "Special Education",
        "Early Childhood Education"
      ]
    },
    "Arts and Languages": {
      "wilayas": ["Algiers", "Oran", "Bejaia", "Tizi Ouzou"],
      "universities": {
        "Algiers": ["University of Algiers 2"],
        "Oran": ["University of Oran 2"],
        "Bejaia": ["Abderrahmane Mira University"],
        "Tizi Ouzou": ["Mouloud Mammeri University"]
      },
      "specialities": [
        "Arabic Literature",
        "French Literature",
        "English Literature",
        "Translation"
      ]
    },
    "Engineering Fields": {
      "wilayas": ["Algiers", "Annaba", "Blida", "Tlemcen"],
      "universities": {
        "Algiers": ["ENP", "USTHB"],
        "Annaba": ["Badji Mokhtar University"],
        "Blida": ["Saad Dahlab University"],
        "Tlemcen": ["Abou Bekr Belkaid University"]
      },
      "specialities": [
        "Petroleum Engineering",
        "Mining Engineering",
        "Materials Science",
        "Industrial Engineering"
      ]
    }
  };

  await fields.add(fieldsData);
}
