// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Plural format key: "%#@Age@"
  internal static func ages(_ p1: Int) -> String {
    return L10n.tr("Localizable", "ages", p1)
  }

  internal enum Base {
    /// Отменить
    internal static var cancel: String {
      return L10n.tr("Localizable", "base.cancel")
    }
    /// Завершить
    internal static var complete: String {
      return L10n.tr("Localizable", "base.complete")
    }
    /// Удалить
    internal static var delete: String {
      return L10n.tr("Localizable", "base.delete")
    }
    /// Редактировать
    internal static var edit: String {
      return L10n.tr("Localizable", "base.edit")
    }
    /// Сохранить
    internal static var save: String {
      return L10n.tr("Localizable", "base.save")
    }
    internal enum Resume {
      /// Возраст
      internal static var age: String {
        return L10n.tr("Localizable", "base.resume.age")
      }
      /// Дата рождения
      internal static var birthday: String {
        return L10n.tr("Localizable", "base.resume.birthday")
      }
      /// Предмет
      internal static var contact: String {
        return L10n.tr("Localizable", "base.resume.contact")
      }
      /// Желаемая область (опционально)
      internal static var contacts: String {
        return L10n.tr("Localizable", "base.resume.contacts")
      }
      /// Область
      internal static var field: String {
        return L10n.tr("Localizable", "base.resume.field")
      }
      /// ЕГЭ
      internal static var fields: String {
        return L10n.tr("Localizable", "base.resume.fields")
      }
      /// Очно/Заочно
      internal static var job: String {
        return L10n.tr("Localizable", "base.resume.job")
      }
      /// Балл (опционально)
      internal static var link: String {
        return L10n.tr("Localizable", "base.resume.link")
      }
      /// Форма обучения (опционально)
      internal static var main: String {
        return L10n.tr("Localizable", "base.resume.main")
      }
      /// Результат
      internal static var name: String {
        return L10n.tr("Localizable", "base.resume.name")
      }
      /// Выбор направления
      internal static var title: String {
        return L10n.tr("Localizable", "base.resume.title")
      }
    }
  }

  internal enum Main {
    internal enum ConfirmationDialog {
      /// Удалить анкету
      internal static var deleteResume: String {
        return L10n.tr("Localizable", "main.confirmation-dialog.delete-resume")
      }
      /// Редактировать анкету
      internal static var editResume: String {
        return L10n.tr("Localizable", "main.confirmation-dialog.edit-resume")
      }
    }
    internal enum DeleteResumeAlert {
      /// Анкета будет стерта без возможности восстановления
      internal static var description: String {
        return L10n.tr("Localizable", "main.delete-resume-alert.description")
      }
      /// Удаление анкету
      internal static var title: String {
        return L10n.tr("Localizable", "main.delete-resume-alert.title")
      }
    }
    internal enum ResumeSection {
      /// Время выбрать своё направление!
      internal static var empty: String {
        return L10n.tr("Localizable", "main.resume-section.empty")
      }
    }
    internal enum Toolbar {
      /// Моё будущее в РГУ
      internal static var title: String {
        return L10n.tr("Localizable", "main.toolbar.title")
      }
    }
  }

  internal enum ResumeEditor {
    /// Добавить предмет
    internal static var addContact: String {
      return L10n.tr("Localizable", "resume-editor.add-contact")
    }
    /// Добавить область
    internal static var addField: String {
      return L10n.tr("Localizable", "resume-editor.add-field")
    }
    /// Выбрать фото
    internal static var selectPhoto: String {
      return L10n.tr("Localizable", "resume-editor.select-photo")
    }
    internal enum Toolbar {
      /// Анкета
      internal static var title: String {
        return L10n.tr("Localizable", "resume-editor.toolbar.title")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: BundleToken.bundle, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type


