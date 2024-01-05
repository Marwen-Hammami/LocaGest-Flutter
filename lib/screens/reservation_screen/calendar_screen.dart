import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:locagest/models/reservation.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Reservation> reservations = [];

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }


void updateReservations(List<Reservation> newReservations) {
    setState(() {
      reservations = newReservations;
    });
  }


  Future<void> fetchReservations() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:9090/res'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Reservation> fetchedReservations = data
            .map((reservation) => Reservation.fromJson(reservation))
            .toList();

        setState(() {
          reservations = fetchedReservations;
        });
      } else {
        throw Exception('Failed to load reservations');
      }
    } catch (e) {
      print('Error fetching reservations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des réservations'),
      ),
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 6,
        dataSource: MeetingDataSource(getAppointmentsEvents()),
        onTap: (CalendarTapDetails details) {
          if (details.appointments != null &&
              details.appointments!.isNotEmpty) {
            showReservationDetails(context, details.appointments![0]);
          }
        },
      ),
    );
  }

List<Appointment> getAppointmentsEvents() {
  List<Appointment> meetings = <Appointment>[];

  for (var reservation in reservations) {
    meetings.add(Appointment(
      startTime: reservation.DateDebut,
      endTime: reservation.DateFin,
      subject: 'Statut: ${reservation.Statut}',
      color: getStatusColor(reservation.Statut), // Utilisez une fonction pour déterminer la couleur en fonction du statut
      isAllDay: false,
    ));
  }

  return meetings;
}

Color getStatusColor(String statut) {
  // Logique pour déterminer la couleur en fonction du statut
  // Par exemple, vous pouvez utiliser une déclaration switch ou if-else
  switch (statut) {
    case 'Statut1':
      return Colors.green;
    case 'Statut2':
      return Colors.blue;
    case 'Statut3':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}



  void showReservationDetails(BuildContext context, Appointment appointment) {
    String? eventTitle = appointment.notes;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reservation Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event Title: $eventTitle'),
              // Ajoutez d'autres détails de réservation ici en fonction de votre structure
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
