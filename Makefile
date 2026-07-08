# Standard targets for humans and agents. Flutter may live off PATH at
# /opt/flutter; prepend it if `flutter` is not found.
PACKAGES := packages/atomsn apps/demo

.PHONY: setup lint test check

setup:
	@for p in $(PACKAGES); do (cd $$p && flutter pub get) || exit 1; done

lint:
	@for p in $(PACKAGES); do (cd $$p && flutter analyze) || exit 1; done

test:
	@for p in $(PACKAGES); do (cd $$p && flutter test) || exit 1; done

check: lint test
