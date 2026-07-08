import 'package:atomsn/atomsn.dart';
import 'package:flutter/widgets.dart';

import '../widgets/demo_block.dart';

/// Demo screen for all of the AtomSN package's molecules.
class MoleculesScreen extends StatefulWidget {
  const MoleculesScreen({super.key});

  @override
  State<MoleculesScreen> createState() => _MoleculesScreenState();
}

class _MoleculesScreenState extends State<MoleculesScreen> {
  String? _selectedTeam;
  String? _searchedTeam;
  String? _selectedZone;
  List<String> _selectedTeams = const [];
  DateTime? _selectedDate;
  AsnTime? _selectedTime;
  AsnTime? _selectedTimePeriod;
  List<String> _chips = const ['design', 'frontend'];
  String _phone = '+34';
  int _page = 1;
  bool _collapsed = false;
  Color? _color = const Color(0xFF6366F1);
  String _tab = 'overview';
  bool _popoverVisible = false;

  static const List<AsnSelectOption<String>> _teamOptions = [
    AsnSelectOption(value: 'avengers', label: 'The Avengers'),
    AsnSelectOption(value: 'liga', label: 'Justice League'),
    AsnSelectOption(value: 'guardianes', label: 'Guardians of the Galaxy'),
  ];

  // Long list to showcase the popover scrolling.
  static const List<AsnSelectOption<String>> _zoneOptions = [
    AsnSelectOption(value: 'est', label: 'Eastern Standard Time (EST)'),
    AsnSelectOption(value: 'cst', label: 'Central Standard Time (CST)'),
    AsnSelectOption(value: 'mst', label: 'Mountain Standard Time (MST)'),
    AsnSelectOption(value: 'pst', label: 'Pacific Standard Time (PST)'),
    AsnSelectOption(value: 'akst', label: 'Alaska Standard Time (AKST)'),
    AsnSelectOption(value: 'hst', label: 'Hawaii Standard Time (HST)'),
    AsnSelectOption(value: 'gmt', label: 'Greenwich Mean Time (GMT)'),
    AsnSelectOption(value: 'cet', label: 'Central European Time (CET)'),
    AsnSelectOption(value: 'eet', label: 'Eastern European Time (EET)'),
    AsnSelectOption(value: 'msk', label: 'Moscow Time (MSK)'),
    AsnSelectOption(value: 'ist', label: 'India Standard Time (IST)'),
    AsnSelectOption(value: 'jst', label: 'Japan Standard Time (JST)'),
    AsnSelectOption(value: 'aest', label: 'Australian Eastern Time (AEST)'),
    AsnSelectOption(value: 'nzst', label: 'New Zealand Standard Time (NZST)'),
    AsnSelectOption(value: 'brt', label: 'Brasilia Time (BRT)'),
  ];

  static const List<Color> _swatches = [
    Color(0xFF6366F1),
    Color(0xFFEC4899),
    Color(0xFF22C55E),
    Color(0xFFF59E0B),
    Color(0xFF06B6D4),
    Color(0xFFEF4444),
  ];

  @override
  Widget build(BuildContext context) {
    return DemoScreen(
      blocks: [
        DemoBlock(
          title: 'AsnSelect',
          child: AsnSelect<String>(
            value: _selectedTeam,
            placeholder: 'Select a team',
            options: _teamOptions,
            onChanged: (value) => setState(() => _selectedTeam = value),
          ),
        ),
        DemoBlock(
          title: 'AsnSelect.withSearch',
          child: AsnSelect<String>.withSearch(
            value: _searchedTeam,
            placeholder: 'Search a team',
            searchPlaceholder: 'Type to filter...',
            options: _teamOptions,
            onChanged: (value) => setState(() => _searchedTeam = value),
          ),
        ),
        DemoBlock(
          title: 'AsnSelect (scrollable)',
          child: AsnSelect<String>(
            value: _selectedZone,
            placeholder: 'Select a timezone',
            options: _zoneOptions,
            onChanged: (value) => setState(() => _selectedZone = value),
          ),
        ),
        DemoBlock(
          title: 'AsnMultiSelect',
          child: AsnMultiSelect<String>(
            values: _selectedTeams,
            placeholder: 'Select teams',
            options: _teamOptions,
            onChanged: (values) => setState(() => _selectedTeams = values),
          ),
        ),
        DemoBlock(
          title: 'AsnAlert',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              AsnAlert(
                title: Text('Normal'),
                description: Text('Neutral message with no tint or icon.'),
              ),
              SizedBox(height: AsnSpacing.x3),
              AsnAlert(
                variant: AsnStatusVariant.info,
                title: Text('Information'),
                description: Text('Your session will end in 5 minutes.'),
              ),
              SizedBox(height: AsnSpacing.x3),
              AsnAlert(
                variant: AsnStatusVariant.warning,
                title: Text('Warning'),
                description: Text('You have unsaved changes.'),
              ),
              SizedBox(height: AsnSpacing.x3),
              AsnAlert(
                variant: AsnStatusVariant.error,
                title: Text('Error'),
                description: Text('The document could not be saved.'),
              ),
              SizedBox(height: AsnSpacing.x3),
              AsnAlert(
                variant: AsnStatusVariant.success,
                title: Text('Done'),
                description: Text('The document was saved successfully.'),
              ),
            ],
          ),
        ),
        const DemoBlock(
          title: 'AsnCard',
          child: AsnCard(
            title: Text('Pro Plan'),
            description: Text('Monthly billing'),
            footer: Text('29 EUR / month'),
            child: Text('Includes priority support and unlimited users.'),
          ),
        ),
        const DemoBlock(
          title: 'AsnAccordion',
          child: AsnAccordion(
            items: [
              AsnAccordionItem(
                title: Text('What is AtomSN?'),
                content: Text('A component library for Flutter.'),
              ),
              AsnAccordionItem(
                title: Text('Is it open source?'),
                content: Text('Yes, it ships under a permissive license.'),
              ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnTabs',
          child: AsnTabs<String>(
            value: _tab,
            onChanged: (value) => setState(() => _tab = value),
            tabs: const [
              AsnTabItem(
                value: 'overview',
                label: Text('Overview'),
                content: Text('General view of the project.'),
              ),
              AsnTabItem(
                value: 'activity',
                label: Text('Activity'),
                content: Text("The team's latest changes."),
              ),
              AsnTabItem(
                value: 'settings',
                label: Text('Settings'),
                content: Text('Preferences and permissions.'),
              ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnBreadcrumb',
          child: AsnBreadcrumb(
            items: [
              AsnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
              AsnBreadcrumbItem.ellipsis(
                menuItems: [
                  AsnBreadcrumbMenuItem(
                    label: const Text('Documentation'),
                    onTap: () {},
                  ),
                  AsnBreadcrumbMenuItem(
                    label: const Text('Themes'),
                    onTap: () {},
                  ),
                  AsnBreadcrumbMenuItem(
                    label: const Text('GitHub'),
                    onTap: () {},
                  ),
                ],
              ),
              AsnBreadcrumbItem(label: const Text('Components'), onTap: () {}),
              const AsnBreadcrumbItem(label: Text('Breadcrumb')),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnBreadcrumb — custom separator',
          child: AsnBreadcrumb(
            separator: const Text('/'),
            items: [
              AsnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
              AsnBreadcrumbItem(label: const Text('Components'), onTap: () {}),
              const AsnBreadcrumbItem(label: Text('Breadcrumb')),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnBreadcrumb — dropdown',
          child: AsnBreadcrumb(
            items: [
              AsnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
              AsnBreadcrumbItem.dropdown(
                trigger: const Text('Components'),
                menuItems: [
                  AsnBreadcrumbMenuItem(
                    label: const Text('Documentation'),
                    onTap: () {},
                  ),
                  AsnBreadcrumbMenuItem(
                    label: const Text('Themes'),
                    onTap: () {},
                  ),
                  AsnBreadcrumbMenuItem(
                    label: const Text('GitHub'),
                    onTap: () {},
                  ),
                ],
              ),
              const AsnBreadcrumbItem(label: Text('Breadcrumb')),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnCalendar',
          child: SizedBox(
            height: 360,
            child: AsnCalendar(
              selected: _selectedDate,
              onChanged: (date) => setState(() => _selectedDate = date),
            ),
          ),
        ),
        DemoBlock(
          title: 'AsnTimePicker',
          child: AsnTimePicker(
            value: _selectedTime,
            onChanged: (time) => setState(() => _selectedTime = time),
          ),
        ),
        DemoBlock(
          title: 'AsnTimePicker.period',
          child: AsnTimePicker.period(
            value: _selectedTimePeriod,
            onChanged: (time) => setState(() => _selectedTimePeriod = time),
          ),
        ),
        DemoBlock(
          title: 'AsnPopover',
          child: AsnPopover(
            visible: _popoverVisible,
            onVisibleChanged: (visible) =>
                setState(() => _popoverVisible = visible),
            popover: const SizedBox(
              width: 200,
              child: Text('Popover content anchored to the button.'),
            ),
            child: AsnButton(
              variant: AsnButtonVariant.outline,
              size: AsnButtonSize.sm,
              onPressed: () =>
                  setState(() => _popoverVisible = !_popoverVisible),
              child: const Text('Open popover'),
            ),
          ),
        ),
        DemoBlock(
          title: 'AsnFormField',
          child: AsnFormField(
            label: 'Email',
            description: 'We will use this address for notifications.',
            child: AsnInput(
              placeholder: 'you@company.com',
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
        DemoBlock(
          title: 'AsnChipInput',
          child: AsnChipInput(
            values: _chips,
            placeholder: 'Type and press Enter',
            onChanged: (values) => setState(() => _chips = values),
          ),
        ),
        DemoBlock(
          title: 'AsnPhoneInput',
          child: AsnPhoneInput(
            value: _phone,
            placeholder: 'Phone number',
            onChanged: (value) => setState(() => _phone = value),
          ),
        ),
        const DemoBlock(
          title: 'AsnAvatarGroup',
          child: AsnAvatarGroup(
            srcs: [
              'https://i.pravatar.cc/100?img=1',
              'https://i.pravatar.cc/100?img=2',
              'https://i.pravatar.cc/100?img=3',
              'https://i.pravatar.cc/100?img=4',
              'https://i.pravatar.cc/100?img=5',
              'https://i.pravatar.cc/100?img=6',
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnPagination',
          child: AsnPagination(
            page: _page,
            pageCount: 5,
            onChanged: (page) => setState(() => _page = page),
          ),
        ),
        DemoBlock(
          title: 'AsnCollapsible',
          child: AsnCollapsible(
            expanded: !_collapsed,
            onChanged: (expanded) => setState(() => _collapsed = !expanded),
            header: const Text('Advanced details'),
            child: const Text(
              'Optional configuration shown when you expand the section.',
            ),
          ),
        ),
        DemoBlock(
          title: 'AsnColorPicker',
          child: AsnColorPicker(
            swatches: _swatches,
            value: _color,
            onChanged: (color) => setState(() => _color = color),
          ),
        ),
        const DemoBlock(
          title: 'AsnTracker',
          child: AsnTracker(
            cells: [
              AsnTrackerCell(tooltip: 'Operational'),
              AsnTrackerCell(tooltip: 'Operational'),
              AsnTrackerCell(
                color: Color(0xFFF59E0B),
                tooltip: 'Degraded',
              ),
              AsnTrackerCell(tooltip: 'Operational'),
              AsnTrackerCell(
                color: Color(0xFFEF4444),
                tooltip: 'Outage',
              ),
              AsnTrackerCell(tooltip: 'Operational'),
              AsnTrackerCell(tooltip: 'Operational'),
            ],
          ),
        ),
        const DemoBlock(
          title: 'AsnHoverCard',
          child: AsnHoverCard(
            card: Text(
              'Floating card that appears when you hover over it.',
            ),
            child: Text('Hover the cursor here'),
          ),
        ),
      ],
    );
  }
}
