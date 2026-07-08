import 'package:atomsn/atomsn.dart';
import 'package:flutter/widgets.dart';

import '../widgets/demo_block.dart';

/// Screen that shows all of the AtomSN package's organisms.
class OrganismsScreen extends StatefulWidget {
  const OrganismsScreen({super.key});

  @override
  State<OrganismsScreen> createState() => _OrganismsScreenState();
}

class _OrganismsScreenState extends State<OrganismsScreen> {
  int _stepperIndex = 1;
  int _stepsIndex = 1;
  int _navIndex = 0;
  DateTime? _selectedDate;
  Set<String> _expandedIds = {'src'};

  static const _navLabels = ['Home', 'Articles', 'Archive', 'About'];

  static const List<AsnSelectOption<String>> _teamOptions = [
    AsnSelectOption(value: 'avengers', label: 'The Avengers'),
    AsnSelectOption(value: 'liga', label: 'Justice League'),
    AsnSelectOption(value: 'guardianes', label: 'Guardians of the Galaxy'),
  ];

  static const _tree = [
    AsnTreeNode(
      id: 'src',
      label: 'lib',
      children: [
        AsnTreeNode(
          id: 'components',
          label: 'components',
          children: [
            AsnTreeNode(id: 'atoms', label: 'atoms'),
            AsnTreeNode(id: 'molecules', label: 'molecules'),
            AsnTreeNode(id: 'organisms', label: 'organisms'),
          ],
        ),
        AsnTreeNode(id: 'main', label: 'main.dart'),
      ],
    ),
  ];

  void _toggle(String id) {
    setState(() {
      _expandedIds = {..._expandedIds};
      if (!_expandedIds.add(id)) _expandedIds.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AsnTheme.of(context);

    return DemoScreen(
      blocks: [
        DemoBlock(
          title: 'AsnForm',
          child: AsnForm(
            child: Builder(
              builder: (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AsnInputFormField(
                    id: 'email',
                    label: 'Email',
                    placeholder: 'you@company.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value.contains('@') ? null : 'Enter a valid email',
                  ),
                  const SizedBox(height: AsnSpacing.x3),
                  const AsnSelectFormField<String>(
                    id: 'team',
                    label: 'Team',
                    placeholder: 'Select a team',
                    options: _teamOptions,
                  ),
                  const SizedBox(height: AsnSpacing.x3),
                  AsnCheckboxFormField(
                    id: 'terms',
                    inputLabel: const Text('I accept the terms'),
                    validator: (checked) =>
                        checked ? null : 'You must accept the terms',
                  ),
                  const SizedBox(height: AsnSpacing.x4),
                  AsnButton(
                    onPressed: () => AsnForm.of(context).validate(),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
        DemoBlock(
          title: 'AsnDialog',
          child: Row(
            children: [
              AsnButton(
                onPressed: () => AsnDialog.show<void>(
                  context,
                  title: const Text('Publish edition'),
                  description: const Text(
                    'The edition will be sent to print immediately.',
                  ),
                  actions: [
                    AsnButton(
                      variant: AsnButtonVariant.ghost,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    AsnButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Publish'),
                    ),
                  ],
                ),
                child: const Text('Open dialog'),
              ),
              const SizedBox(width: AsnSpacing.x3),
              AsnButton(
                variant: AsnButtonVariant.destructive,
                onPressed: () => AsnDialog.showAlert<void>(
                  context,
                  title: const Text('Delete draft'),
                  description: const Text('This action cannot be undone.'),
                  actions: [
                    AsnButton(
                      variant: AsnButtonVariant.ghost,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    AsnButton(
                      variant: AsnButtonVariant.destructive,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
                child: const Text('Open alert'),
              ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnSheet',
          child: Row(
            children: [
              AsnButton(
                variant: AsnButtonVariant.outline,
                onPressed: () => AsnSheet.show<void>(
                  context,
                  side: AsnSheetSide.right,
                  title: const Text('Filters'),
                  description: const Text('Adjust the list of articles.'),
                  child: const Text('Side panel content.'),
                ),
                child: const Text('Sheet right'),
              ),
              const SizedBox(width: AsnSpacing.x3),
              AsnButton(
                variant: AsnButtonVariant.outline,
                onPressed: () => AsnSheet.show<void>(
                  context,
                  side: AsnSheetSide.bottom,
                  title: const Text('Actions'),
                  child: const Text('Panel anchored at the bottom.'),
                ),
                child: const Text('Sheet bottom'),
              ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnContextMenu',
          child: AsnContextMenu(
            items: [
              AsnMenuItem(label: 'Copy', onTap: () {}),
              AsnMenuItem(label: 'Paste', onTap: () {}),
              const AsnMenuItem(label: 'Delete', enabled: false),
            ],
            child: Container(
              padding: const EdgeInsets.all(AsnSpacing.x4),
              decoration: BoxDecoration(
                color: colors.bgSubtle,
                borderRadius: AsnRadius.brMd,
                border: Border.all(color: colors.borderDefault),
              ),
              child: const Text(
                'Right-click or long-press here',
              ),
            ),
          ),
        ),
        DemoBlock(
          title: 'AsnMenubar',
          child: AsnMenubar(
            menus: [
              AsnMenu(
                label: 'File',
                items: [
                  AsnMenuItem(label: 'New', onTap: () {}),
                  AsnMenuItem(label: 'Open', onTap: () {}),
                  AsnMenuItem(label: 'Save', onTap: () {}),
                ],
              ),
              AsnMenu(
                label: 'Edit',
                items: [
                  AsnMenuItem(label: 'Undo', onTap: () {}),
                  AsnMenuItem(label: 'Redo', onTap: () {}),
                ],
              ),
              AsnMenu(
                label: 'View',
                items: [
                  AsnMenuItem(label: 'Zoom +', onTap: () {}),
                  AsnMenuItem(label: 'Zoom -', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnTable',
          // ShadTable uses a 2D viewport: it needs a bounded height inside a
          // ListView. It is constrained with a SizedBox.
          child: SizedBox(
            height: 160,
            child: AsnTable(
              columns: const [
                AsnTableColumn(header: Text('Section')),
                AsnTableColumn(header: Text('Editor')),
                AsnTableColumn(header: Text('Notes')),
              ],
              rows: const [
                [Text('Front Page'), Text('A. Soler'), Text('12')],
                [Text('Culture'), Text('M. Rivas'), Text('8')],
                [Text('Sports'), Text('J. Pena'), Text('15')],
              ],
            ),
          ),
        ),
        DemoBlock(
          title: 'AsnDatePicker',
          child: AsnDatePicker(
            selected: _selectedDate,
            onChanged: (date) => setState(() => _selectedDate = date),
          ),
        ),
        DemoBlock(
          title: 'AsnResizable',
          child: SizedBox(
            height: 160,
            child: AsnResizable(
              axis: AsnResizableAxis.horizontal,
              panels: [
                _panel(colors, 'Index'),
                _panel(colors, 'Document'),
              ],
            ),
          ),
        ),
        DemoBlock(
          title: 'AsnToast',
          child: Wrap(
            spacing: AsnSpacing.x3,
            runSpacing: AsnSpacing.x3,
            children: [
              AsnButton(
                onPressed: () => AsnToast.show(
                  context,
                  title: const Text('Saved'),
                  description: const Text('The draft was saved.'),
                ),
                child: const Text('Normal'),
              ),
              AsnButton(
                onPressed: () => AsnToast.show(
                  context,
                  title: const Text('Information'),
                  description: const Text('An update is available.'),
                  variant: AsnStatusVariant.info,
                ),
                child: const Text('Info'),
              ),
              AsnButton(
                onPressed: () => AsnToast.show(
                  context,
                  title: const Text('Warning'),
                  description: const Text('Your session expires soon.'),
                  variant: AsnStatusVariant.warning,
                ),
                child: const Text('Warning'),
              ),
              AsnButton(
                variant: AsnButtonVariant.destructive,
                onPressed: () => AsnToast.show(
                  context,
                  title: const Text('Error'),
                  description: const Text('Could not connect.'),
                  variant: AsnStatusVariant.error,
                ),
                child: const Text('Error'),
              ),
              AsnButton(
                onPressed: () => AsnToast.show(
                  context,
                  title: const Text('Done'),
                  description: const Text('The changes were published.'),
                  variant: AsnStatusVariant.success,
                ),
                child: const Text('Success'),
              ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnSonner',
          child: Wrap(
            spacing: AsnSpacing.x3,
            runSpacing: AsnSpacing.x3,
            children: [
              AsnButton(
                onPressed: () => AsnSonner.show(
                  context,
                  title: const Text('Uploaded'),
                  description: const Text('File added to the queue.'),
                ),
                child: const Text('Stack a notice'),
              ),
              AsnButton(
                variant: AsnButtonVariant.outline,
                onPressed: () => AsnSonner.show(
                  context,
                  title: const Text('Synced'),
                  description: const Text('Everything is up to date.'),
                  variant: AsnStatusVariant.success,
                ),
                child: const Text('Stack a success'),
              ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnStepper',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AsnStepper(
                currentIndex: _stepperIndex,
                steps: const [
                  AsnStep(title: 'Draft', subtitle: 'Text'),
                  AsnStep(title: 'Review', subtitle: 'Editing'),
                  AsnStep(title: 'Publish', subtitle: 'Output'),
                ],
              ),
              const SizedBox(height: AsnSpacing.x4),
              Row(
                children: [
                  AsnButton(
                    size: AsnButtonSize.sm,
                    variant: AsnButtonVariant.outline,
                    onPressed: _stepperIndex > 0
                        ? () => setState(() => _stepperIndex--)
                        : null,
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: AsnSpacing.x2),
                  AsnButton(
                    size: AsnButtonSize.sm,
                    onPressed: _stepperIndex < 2
                        ? () => setState(() => _stepperIndex++)
                        : null,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnSteps',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AsnSteps(
                currentIndex: _stepsIndex,
                steps: const [
                  AsnStep(title: 'Create account', subtitle: 'Basic details'),
                  AsnStep(title: 'Confirm email', subtitle: 'Verification'),
                  AsnStep(title: 'Done', subtitle: 'Full access'),
                ],
              ),
              Row(
                children: [
                  AsnButton(
                    size: AsnButtonSize.sm,
                    variant: AsnButtonVariant.outline,
                    onPressed: _stepsIndex > 0
                        ? () => setState(() => _stepsIndex--)
                        : null,
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: AsnSpacing.x2),
                  AsnButton(
                    size: AsnButtonSize.sm,
                    onPressed: _stepsIndex < 2
                        ? () => setState(() => _stepsIndex++)
                        : null,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const DemoBlock(
          title: 'AsnTimeline',
          child: AsnTimeline(
            entries: [
              AsnTimelineEntry(
                title: 'Draft created',
                time: '09:14',
                child: Text('First outline of the article.'),
              ),
              AsnTimelineEntry(
                title: 'Sent for review',
                time: '11:30',
              ),
              AsnTimelineEntry(
                title: 'Approved',
                time: '15:02',
                child: Text('Ready for layout.'),
              ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnTree',
          child: AsnTree(
            roots: _tree,
            expandedIds: _expandedIds,
            onToggle: _toggle,
          ),
        ),
        DemoBlock(
          title: 'AsnNavigationMenu',
          child: AsnNavigationMenu(
            items: [
              for (var i = 0; i < _navLabels.length; i++)
                AsnNavItem(
                  label: _navLabels[i],
                  selected: i == _navIndex,
                  onTap: () => setState(() => _navIndex = i),
                ),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnCommand',
          child: SizedBox(
            height: 240,
            child: AsnCommand(
              placeholder: 'Search command...',
              items: [
                AsnCommandItem(
                  label: 'New article',
                  keywords: const ['create', 'post'],
                  onSelected: () {},
                ),
                AsnCommandItem(
                  label: 'Search file',
                  keywords: const ['open', 'file'],
                  onSelected: () {},
                ),
                AsnCommandItem(
                  label: 'Settings',
                  keywords: const ['config', 'preferences'],
                  onSelected: () {},
                ),
              ],
            ),
          ),
        ),
        DemoBlock(
          title: 'AsnCarousel',
          child: AsnCarousel(
            height: 160,
            items: [
              _card(colors, 'Edition 1'),
              _card(colors, 'Edition 2'),
              _card(colors, 'Edition 3'),
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnDataTable',
          child: AsnDataTable(
            columns: [
              AsnDataColumn(label: 'Title', onSort: () {}),
              AsnDataColumn(label: 'Author', onSort: () {}),
              const AsnDataColumn(label: 'Status'),
            ],
            rows: const [
              [Text('The Silent Strike'), Text('A. Soler'), Text('Published')],
              [Text('Neighborhood Chronicle'), Text('M. Rivas'), Text('Draft')],
              [Text('Cup Final'), Text('J. Pena'), Text('Review')],
            ],
          ),
        ),
        DemoBlock(
          title: 'AsnDrawer',
          child: Row(
            children: [
              AsnButton(
                variant: AsnButtonVariant.outline,
                onPressed: () => AsnDrawer.show<void>(
                  context,
                  side: AsnDrawerSide.left,
                  child: const Text('Navigation in the left drawer.'),
                ),
                child: const Text('Drawer left'),
              ),
              const SizedBox(width: AsnSpacing.x3),
              AsnButton(
                variant: AsnButtonVariant.outline,
                onPressed: () => AsnDrawer.show<void>(
                  context,
                  side: AsnDrawerSide.right,
                  child: const Text('Details in the right drawer.'),
                ),
                child: const Text('Drawer right'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _panel(AsnSemanticColors colors, String label) {
    return Container(
      alignment: Alignment.center,
      color: colors.bgSubtle,
      child: Text(label, style: TextStyle(color: colors.textSecondary)),
    );
  }

  Widget _card(AsnSemanticColors colors, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AsnSpacing.x1),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.bgSubtle,
        borderRadius: AsnRadius.brMd,
        border: Border.all(color: colors.borderDefault),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: AsnTextTheme.fontFamily,
          fontSize: AsnFontSize.xl2,
          fontWeight: AsnFontWeight.semibold,
          color: colors.textPrimary,
        ),
      ),
    );
  }
}
