//
//  MainView.swift
//
//  AlexFofonov in 2025
//

import SwiftData
import SwiftUI

struct MainView<ViewModel: MainViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    @Environment(\.router) private var router
    @Environment(\.modelContext) private var modelContext
    @Query private var resumeModelQuery: [ResumeModel]

    @State private var showingEditingDialog: Bool = false
    @State private var showingResumeDeletionAlert: Bool = false
    @State private var clippedLinkIds: [UUID] = []

    var body: some View {
        Form {
            Section(L10n.Base.Resume.title) {
                List {
                    if let uiImage = viewModel.state.resume.uiImage {
                        HStack {
                            Spacer()

                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(maxWidth: 200, maxHeight: 200)
                                .animation(nil, value: clippedLinkIds)

                            Spacer()
                        }
                    }

                    if viewModel.state.resume.isEmpty {
                        TitleButton(L10n.Main.ResumeSection.empty) {
                            viewModel.handle(.onEditResume)
                        }
                    }

                    if !viewModel.state.resume.name.isEmpty {
                        LabeledContent(L10n.Base.Resume.name, value: viewModel.state.resume.name)
                    }

                    if !viewModel.state.resume.age.isEmpty {
                        LabeledContent(L10n.Base.Resume.age, value: viewModel.state.resume.age)
                    }

                    if !viewModel.state.resume.job.isEmpty {
                        LabeledContent(L10n.Base.Resume.job, value: viewModel.state.resume.job)
                    }

                    if !viewModel.state.resume.contacts.isEmpty {
                        DisclosureGroup {
                            ForEach(viewModel.state.resume.contacts, id: \.id) { contact in
                                HStack {
                                    LabeledContent(contact.title, value: contact.link)
                                }
                            }
                        } label: {
                            Text(L10n.Base.Resume.fields)
                                .bold()
                        }
                    }

                    if !viewModel.state.resume.fields.isEmpty {
                        DisclosureGroup {
                            ForEach(viewModel.state.resume.fields, id: \.id) { field in
                                HStack(alignment: .top) {
                                    Text(field.title)
                                        .frame(width: 100, alignment: .leading)
                                        .padding(.trailing, 10)

                                    Spacer()

                                    Text(field.description)
                                        .foregroundStyle(.gray)
                                        .font(.caption)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        } label: {
                            Text(L10n.Base.Resume.contacts)
                                .bold()
                        }
                    }
                }
            }
            
            if !viewModel.state.resume.contacts.isEmpty {
                Section("Результат") {
                    List {
                        Label {
                            Text(result(array: viewModel.state.resume.contacts.map(\.title)))
                        } icon: {
                            
                        }
                    }
                }
            }
        }
        .navigationTitle(L10n.Main.Toolbar.title)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(L10n.Base.edit) {
                    showingEditingDialog.toggle()
                }
                .confirmationDialog(
                    "",
                    isPresented: $showingEditingDialog,
                    titleVisibility: .hidden,
                    actions: {
                        Button(L10n.Main.ConfirmationDialog.editResume) {
                            viewModel.handle(.onEditResume)
                        }

                        Button(L10n.Main.ConfirmationDialog.deleteResume, role: .destructive) {
                            showingResumeDeletionAlert.toggle()
                        }

                        Button(L10n.Base.cancel, role: .cancel) {}
                    }
                )
                .opacity(viewModel.state.resume.isEmpty ? 0 : 1)
            }
        }
        .alert(L10n.Main.DeleteResumeAlert.title, isPresented: $showingResumeDeletionAlert, actions: {
            Button(L10n.Base.cancel, role: .cancel) {}

            Button(L10n.Base.delete, role: .destructive) {
                viewModel.handle(.onDeleteResume)
            }
        }, message: {
            Text(L10n.Main.DeleteResumeAlert.description)
        })
        .onAppear {
            viewModel.handle(.setup(
                router: router,
                resumeModelQuery: resumeModelQuery,
                modelContext: modelContext
            ))
        }
    }
    
    func result(array: [String]) -> String {
        guard !array.isEmpty else { return "-" }
        
        let count = array.reduce(String()) { partialResult, string in
            return partialResult + string
        }.count
        
        if !array.filter({ ["география"].contains($0.lowercased()) }).isEmpty {
            let result = [
                "Туризм"
            ]
            return result[result.count / (50 / count) >= result.count ? 0 : result.count / (50 / count)]
        }
        
        if !array.filter({ ["информатика"].contains($0.lowercased()) }).isEmpty {
            let result = [
                "Информационные системы и технологии",
                "Прикладная информатика"
            ]
            return result[result.count / (50 / count) >= result.count ? 0 : result.count / (50 / count)]
        }
        
        if !array.filter({ ["история", "обществознание", "литература"].contains($0.lowercased()) || $0.lowercased().contains("язык") }).isEmpty {
            let result = [
                "Дизайн",
                "Графический дизайн",
                "Дизайн костюма",
                "Дизайн аксессуаров",
                "Дизайн среды",
                "Декоративно-прикладное искусство и народные промыслы",
                "Искусство костюма и текстиля",
                "Художественное проектирование изделий текстильной и легкой промышленности",
                "Менеджмент",
                "Экономика",
                "Торговое дело",
                "Гостиничное дело",
                "Реклама и связи с общественностью",
                "Управление качеством"
            ]
            return result[result.count / (50 / count) >= result.count ? 0 : result.count / (50 / count)]
        }
        
        if !array.filter({ ["математика", "физика", "химия", "биология"].contains($0.lowercased()) }).isEmpty {
            let result = [
                "Технология изделий легкой промышленности",
                "Конструирование изделий легкой промышленности",
                "Химическая технология",
                "Наноинженерия",
                "Техносферная безопасность",
                "Материаловедение и технологии материалов",
                "Биотехнология"
            ]
            return result[result.count / (50 / count) >= result.count ? 0 : result.count / (50 / count)]
        }
        
        return "-"
    }
}
