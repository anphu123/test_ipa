// enum TimePeriod { morning, afternoon, evening }

// class TimeSlotModel {
//   final String period;
//   final String time;
//   final bool isRecommended;
//   final TimePeriod timePeriod;

//   const TimeSlotModel({
//     required this.period,
//     required this.time,
//     required this.isRecommended,
//     required this.timePeriod,
//   });

//   static List<TimeSlotModel> getTimeSlotsForDate(int dateIndex) {
//     return [
//       // Morning
//       TimeSlotModel(
//         period: 'Sáng',
//         time: '09:00-12:00',
//         isRecommended: false,
//         timePeriod: TimePeriod.morning,
//       ),
      
//       // Afternoon
//       TimeSlotModel(
//         period: 'Chiều',
//         time: '12:00-15:00',
//         isRecommended: dateIndex == 2,
//         timePeriod: TimePeriod.afternoon,
//       ),
//       TimeSlotModel(
//         period: '',
//         time: '15:00-18:00',
//         isRecommended: dateIndex == 2,
//         timePeriod: TimePeriod.afternoon,
//       ),
      
//       // Evening
//       TimeSlotModel(
//         period: 'Tối',
//         time: '18:00-19:00',
//         isRecommended: false,
//         timePeriod: TimePeriod.evening,
//       ),
//     ];
//   }
// }