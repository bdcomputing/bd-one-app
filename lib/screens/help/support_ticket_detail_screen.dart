import 'package:bdoneapp/components/shared/header.dart';
import 'package:bdoneapp/core/styles.dart';
import 'package:bdoneapp/models/common/support_request.dart';
import 'package:bdoneapp/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class SupportTicketDetailScreen extends ConsumerStatefulWidget {
  final String ticketId;

  const SupportTicketDetailScreen({super.key, required this.ticketId});

  @override
  ConsumerState<SupportTicketDetailScreen> createState() =>
      _SupportTicketDetailScreenState();
}

class _SupportTicketDetailScreenState
    extends ConsumerState<SupportTicketDetailScreen> {
  SupportRequest? _ticket;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchTicketDetails();
  }

  Future<void> _fetchTicketDetails() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final service = ref.read(supportServiceProvider);
      final ticket = await service.fetchSupportRequestById(widget.ticketId);
      if (mounted) {
        setState(() {
          _ticket = ticket;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load ticket details';
          _isLoading = false;
        });
      }
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'OPEN':
        return const Color(0xFFE0F2FE); // Blue 100
      case 'IN_PROGRESS':
        return const Color(0xFFFEF3C7); // Amber 100
      case 'RESOLVED':
      case 'CLOSED':
        return const Color(0xFFD1FAE5); // Emerald 100
      default:
        return const Color(0xFFF3F4F6); // Gray 100
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toUpperCase()) {
      case 'OPEN':
        return const Color(0xFF0369A1); // Blue 700
      case 'IN_PROGRESS':
        return const Color(0xFFD97706); // Amber 700
      case 'RESOLVED':
      case 'CLOSED':
        return const Color(0xFF059669); // Emerald 700
      default:
        return const Color(0xFF6B7280); // Gray 500
    }
  }

  Color _getPriorityColor(RequestPriorityEnum priority) {
    switch (priority) {
      case RequestPriorityEnum.critical:
      case RequestPriorityEnum.high:
        return Colors.red;
      case RequestPriorityEnum.medium:
        return Colors.orange;
      case RequestPriorityEnum.low:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Header(
        title: 'Ticket Details',
        showProfileIcon: true,
        showCurrencyIcon: false,
        actions: [],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!),
                      TextButton(
                        onPressed: _fetchTicketDetails,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchTicketDetails,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status & Date Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(_ticket!.status),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  _ticket!.status.toUpperCase().replaceAll('_', ' '),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: _getStatusTextColor(_ticket!.status),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat('MMM dd, yyyy • HH:mm')
                                    .format(_ticket!.createdAt),
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Title and ID
                          Text(
                            _ticket!.subject,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '#${_ticket!.ticketNumber}',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontFamily: 'Monospace',
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD1D5DB),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.flag_rounded,
                                size: 16,
                                color: _getPriorityColor(_ticket!.priority),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _ticket!.priority.value.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: _getPriorityColor(_ticket!.priority),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // Description Section
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE5E5E5)),
                            ),
                            child: Text(
                              _ticket!.description,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.textPrimary,
                                height: 1.5,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          if (_ticket!.project != null) ...[
                            const Text(
                              'Related Project',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const HugeIcon(
                                      icon: HugeIcons.strokeRoundedFolder01,
                                      size: 24,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _ticket!.project!.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        const Text(
                                          'Project',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
