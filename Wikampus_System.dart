import 'dart:io';
import 'dart:math';

class SupportTicket {
  String ticketId;
  String user;
  String category;
  String description;
  String priority;
  String status;
  String assignedStaff;
  String resolutionNotes;
  DateTime dateTime;

  SupportTicket({
    required this.ticketId,
    required this.user,
    required this.category,
    required this.description,
    required this.priority,
    required this.status,
    required this.assignedStaff,
    required this.resolutionNotes,
    required this.dateTime,
  });
}

List<SupportTicket> tickets = [];

void main() {
  printHeader();

  while (true) {
    print('\n========== MAIN MENU ==========');
    print('1. Report an IT Problem');
    print('2. View My Tickets');
    print('3. IT Support Management');
    print('4. Exit');
    print('================================');

    stdout.write('Choose an option: ');
    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        reportProblem();
        break;

      case '2':
        viewMyTickets();
        break;

      case '3':
        supportManagement();
        break;

      case '4':
        print('\nThank you for using WiKampus Sɔpɔt.');
        print('Goodbye!');
        return;

      default:
        print('\nInvalid option. Please try again.');
    }
  }
}

// ------------------------------------------------------------
// HEADER
// ------------------------------------------------------------

void printHeader() {
  print('''
========================================================
                 WiKampus Sɔpɔt
          UNIVERSITY IT HELP DESK SYSTEM
   Limkokwing University of Creative Technology
                    Sierra Leone
========================================================
''');
}

// ------------------------------------------------------------
// REPORT PROBLEM
// ------------------------------------------------------------

void reportProblem() {
  print('\n========== REPORT IT PROBLEM ==========');

  stdout.write('Enter your name: ');
  String user = stdin.readLineSync() ?? '';

  if (user.isEmpty) {
    print('Name cannot be empty.');
    return;
  }

  String category = selectCategory();

  print('\n---------- TROUBLESHOOTING ----------');
  print(getRecommendation(category));

  stdout.write('\nDid the troubleshooting solve the problem? (Y/N): ');
  String solved = stdin.readLineSync()?.toUpperCase() ?? '';

  if (solved == 'Y') {
    print('\nGreat! Your problem has been resolved.');
    print('No support ticket was created.');
    return;
  }

  if (solved != 'N') {
    print('\nInvalid response.');
    return;
  }

  print('\nThe problem will now be submitted to IT Support.');

  stdout.write('Describe your problem: ');
  String description = stdin.readLineSync() ?? '';

  if (description.isEmpty) {
    print('Problem description cannot be empty.');
    return;
  }

  String priority = selectPriority();

  String ticketId = generateTicketId();

  SupportTicket ticket = SupportTicket(
    ticketId: ticketId,
    user: user,
    category: category,
    description: description,
    priority: priority,
    status: 'Submitted',
    assignedStaff: 'Not Assigned',
    resolutionNotes: 'No resolution recorded yet.',
    dateTime: DateTime.now(),
  );

  tickets.add(ticket);

  print('\n========================================');
  print('        SUPPORT TICKET CREATED');
  print('========================================');
  print('Ticket ID: $ticketId');
  print('User: $user');
  print('Category: $category');
  print('Priority: $priority');
  print('Status: Submitted');
  print('========================================');
}

// ------------------------------------------------------------
// CATEGORY
// ------------------------------------------------------------

String selectCategory() {
  while (true) {
    print('\n========== PROBLEM CATEGORY ==========');
    print('1. Network/Wi-Fi');
    print('2. Hardware/Computer');
    print('3. Software');
    print('4. Account/Login');
    print('5. Printer');
    print('6. Other');
    print('======================================');

    stdout.write('Select category: ');
    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        return 'Network/Wi-Fi';

      case '2':
        return 'Hardware/Computer';

      case '3':
        return 'Software';

      case '4':
        return 'Account/Login';

      case '5':
        return 'Printer';

      case '6':
        return 'Other';

      default:
        print('Invalid category. Please try again.');
    }
  }
}

// ------------------------------------------------------------
// TROUBLESHOOTING
// ------------------------------------------------------------

String getRecommendation(String category) {
  switch (category) {
    case 'Network/Wi-Fi':
      return '''
Check that Wi-Fi is enabled.
Disconnect and reconnect to the network.
Restart your device and try again.
''';

    case 'Hardware/Computer':
      return '''
Check the power and cable connections.
Restart the computer.
Check whether the problem continues.
''';

    case 'Software':
      return '''
Restart the application.
Check for available updates.
Restart the computer and try again.
''';

    case 'Account/Login':
      return '''
Check your username and password.
Make sure Caps Lock is not enabled.
Try the available account recovery procedure.
''';

    case 'Printer':
      return '''
Check that the printer is powered on.
Check the connection.
Check paper supply and error messages.
Try printing again.
''';

    case 'Other':
      return '''
Please provide a clear description of the problem.
If the problem continues, create a support ticket.
''';

    default:
      return 'Please contact IT Support.';
  }
}

// ------------------------------------------------------------
// PRIORITY
// ------------------------------------------------------------

String selectPriority() {
  while (true) {
    print('\n========== TICKET PRIORITY ==========');
    print('1. Low');
    print('2. Medium');
    print('3. High');
    print('4. Urgent');
    print('=====================================');

    stdout.write('Select priority: ');
    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        return 'Low';

      case '2':
        return 'Medium';

      case '3':
        return 'High';

      case '4':
        return 'Urgent';

      default:
        print('Invalid priority. Please try again.');
    }
  }
}

// ------------------------------------------------------------
// TICKET ID
// ------------------------------------------------------------

String generateTicketId() {
  Random random = Random();
  int number = 1000 + random.nextInt(9000);

  return 'WKS-$number';
}

// ------------------------------------------------------------
// VIEW USER TICKETS
// ------------------------------------------------------------

void viewMyTickets() {
  print('\n========== VIEW MY TICKETS ==========');

  stdout.write('Enter your name: ');
  String user = stdin.readLineSync() ?? '';

  List<SupportTicket> userTickets = tickets
      .where((ticket) => ticket.user == user)
      .toList();

  if (userTickets.isEmpty) {
    print('\nNo tickets found for $user.');
    return;
  }

  for (SupportTicket ticket in userTickets) {
    displayTicket(ticket);
  }
}

// ------------------------------------------------------------
// DISPLAY TICKET
// ------------------------------------------------------------

void displayTicket(SupportTicket ticket) {
  print('''
----------------------------------------
Ticket ID:       ${ticket.ticketId}
User:            ${ticket.user}
Category:        ${ticket.category}
Description:     ${ticket.description}
Priority:        ${ticket.priority}
Status:          ${ticket.status}
Assigned Staff:  ${ticket.assignedStaff}
Date:            ${ticket.dateTime}
Resolution:      ${ticket.resolutionNotes}
----------------------------------------
''');
}

// ------------------------------------------------------------
// IT SUPPORT MANAGEMENT
// ------------------------------------------------------------

void supportManagement() {
  print('\n========== IT SUPPORT MANAGEMENT ==========');

  if (tickets.isEmpty) {
    print('No support tickets have been submitted.');
    return;
  }

  while (true) {
    print('\n1. View All Tickets');
    print('2. Assign Ticket');
    print('3. Update Ticket Status');
    print('4. Add Resolution Notes');
    print('5. Return to Main Menu');

    stdout.write('Choose an option: ');
    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        viewAllTickets();
        break;

      case '2':
        assignTicket();
        break;

      case '3':
        updateTicketStatus();
        break;

      case '4':
        addResolutionNotes();
        break;

      case '5':
        return;

      default:
        print('Invalid option.');
    }
  }
}

// ------------------------------------------------------------
// VIEW ALL TICKETS
// ------------------------------------------------------------

void viewAllTickets() {
  print('\n========== ALL SUPPORT TICKETS ==========');

  if (tickets.isEmpty) {
    print('No tickets available.');
    return;
  }

  for (SupportTicket ticket in tickets) {
    displayTicket(ticket);
  }
}

// ------------------------------------------------------------
// FIND TICKET
// ------------------------------------------------------------

SupportTicket? findTicket(String ticketId) {
  for (SupportTicket ticket in tickets) {
    if (ticket.ticketId.toUpperCase() == ticketId.toUpperCase()) {
      return ticket;
    }
  }

  return null;
}

// ------------------------------------------------------------
// ASSIGN TICKET
// ------------------------------------------------------------

void assignTicket() {
  stdout.write('\nEnter Ticket ID: ');
  String ticketId = stdin.readLineSync() ?? '';

  SupportTicket? ticket = findTicket(ticketId);

  if (ticket == null) {
    print('Ticket not found.');
    return;
  }

  stdout.write('Enter IT Support staff name: ');
  String staff = stdin.readLineSync() ?? '';

  if (staff.isEmpty) {
    print('Staff name cannot be empty.');
    return;
  }

  ticket.assignedStaff = staff;
  ticket.status = 'Assigned';

  print('\nTicket ${ticket.ticketId} assigned to $staff.');
}

// ------------------------------------------------------------
// UPDATE STATUS
// ------------------------------------------------------------

void updateTicketStatus() {
  stdout.write('\nEnter Ticket ID: ');
  String ticketId = stdin.readLineSync() ?? '';

  SupportTicket? ticket = findTicket(ticketId);

  if (ticket == null) {
    print('Ticket not found.');
    return;
  }

  print('\nCurrent Status: ${ticket.status}');

  print('\nSelect New Status:');
  print('1. Submitted');
  print('2. Assigned');
  print('3. In Progress');
  print('4. Resolved');
  print('5. Closed');

  stdout.write('Choose status: ');
  String choice = stdin.readLineSync() ?? '';

  String? newStatus;

  switch (choice) {
    case '1':
      newStatus = 'Submitted';
      break;

    case '2':
      newStatus = 'Assigned';
      break;

    case '3':
      newStatus = 'In Progress';
      break;

    case '4':
      newStatus = 'Resolved';
      break;

    case '5':
      newStatus = 'Closed';
      break;

    default:
      print('Invalid status.');
      return;
  }

  ticket.status = newStatus;

  print('\nTicket ${ticket.ticketId} updated to $newStatus.');
}

// ------------------------------------------------------------
// RESOLUTION NOTES
// ------------------------------------------------------------

void addResolutionNotes() {
  stdout.write('\nEnter Ticket ID: ');
  String ticketId = stdin.readLineSync() ?? '';

  SupportTicket? ticket = findTicket(ticketId);

  if (ticket == null) {
    print('Ticket not found.');
    return;
  }

  stdout.write('Enter resolution notes: ');
  String notes = stdin.readLineSync() ?? '';

  if (notes.isEmpty) {
    print('Resolution notes cannot be empty.');
    return;
  }

  ticket.resolutionNotes = notes;

  print('\nResolution notes successfully added.');
}
