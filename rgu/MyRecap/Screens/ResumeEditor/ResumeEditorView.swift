//
//  ResumeEditorView.swift
//
//  AlexFofonov in 2025
//

import PhotosUI
import SwiftData
import SwiftUI

struct ResumeEditorView<ViewModel: ResumeEditorViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    @Environment(\.modelContext) private var modelContext
    @Query private var resumeModelQuery: [ResumeModel]

    @FocusState private var focusedField: Focusable? {
        willSet {
            viewModel.handle(.onFinishEditing)
        }
    }

    var body: some View {
        Form {
            SectionHeader(L10n.Base.Resume.fields)

            ForEach($viewModel.state.resume.contacts, id: \.id) { contactField in
                Section {
                    HStack {
                        TextField(L10n.Base.Resume.contact, text: contactField.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .focused($focusedField, equals: .contactName(id: contactField.id))
                            .onSubmit {
                                focusedField = .contactLink(id: contactField.id)
                            }
                            .onTapGesture {
                                focusedField = .contactName(id: contactField.id)
                            }

                        IconButton(.remove) {
                            focusedField = nil

                            DispatchQueue.main.async {
                                viewModel.handle(.onRemoveContact(contactId: contactField.id))
                            }
                        }
                    }

                    TextField(L10n.Base.Resume.link, text: contactField.link)
                        .focused($focusedField, equals: .contactLink(id: contactField.id))
                        .onTapGesture {
                            focusedField = .contactLink(id: contactField.id)
                        }
                }
            }

            Section {
                TitleButton(L10n.ResumeEditor.addContact) {
                    viewModel.handle(.onAddContact)
                }
            }

            SectionHeader(L10n.Base.Resume.contacts)

            ForEach($viewModel.state.resume.fields, id: \.id) { resumeField in
                Section {
                    HStack {
                        TextField(L10n.Base.Resume.field, text: resumeField.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .focused($focusedField, equals: .resumeFieldTitle(id: resumeField.id))
                            .onSubmit {
                                focusedField = .resumeFieldDescription(id: resumeField.id)
                            }
                            .onTapGesture {
                                focusedField = .resumeFieldTitle(id: resumeField.id)
                            }

                        IconButton(.remove) {
                            focusedField = nil

                            DispatchQueue.main.async {
                                viewModel.handle(.onRemoveResumeField(fieldId: resumeField.id))
                            }
                        }
                    }

                    TextEditor(text: resumeField.description)
                        .focused($focusedField, equals: .resumeFieldDescription(id: resumeField.id))
                        .onTapGesture {
                            focusedField = .resumeFieldDescription(id: resumeField.id)
                        }
                }
            }

            Section {
                TitleButton(L10n.ResumeEditor.addField) {
                    viewModel.handle(.onAddResumeField)
                }
            }
            
            SectionHeader(L10n.Base.Resume.main)
            
            Section {
                TextField(L10n.Base.Resume.job, text: $viewModel.state.resume.job)
                    .focused($focusedField, equals: .job)
            }
        }
        .autocorrectionDisabled()
        .autocapitalization(.none)
        .listSectionSpacing(.compact)
        .navigationTitle(L10n.ResumeEditor.Toolbar.title)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button(L10n.Base.complete) {
                    focusedField = nil
                }
            }

            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(L10n.Base.save) {
                    viewModel.handle(.onSaveResume)
                }
                .disabled(!viewModel.state.isSaveActive)
            }
        }
        .onAppear {
            viewModel.handle(.setup(modelContext: modelContext, resumeModelQuery: resumeModelQuery))
        }
    }

    private enum Focusable: Hashable {
        case name
        case job

        case contactName(id: UUID)
        case contactLink(id: UUID)

        case resumeFieldTitle(id: UUID)
        case resumeFieldDescription(id: UUID)
    }
}
