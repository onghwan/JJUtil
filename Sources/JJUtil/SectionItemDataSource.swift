//
//  File.swift
//  
//
//  Created by jingjing on 1/28/20.
//

import Foundation

public struct SectionItemDataSource<S: Equatable, R: Equatable> {
    public var sections = [(section: S, items: [R])]()

    public init(_ sections: (S, [R])...) {
        self.sections = sections
    }

    public mutating func append(_ item: R, in section: S) {
        guard let index = sections.firstIndex(where: { $0.section == section }) else { return }

        var items = sections[index].items
        items.append(item)
        sections[index].items = items
    }

    public mutating func insert(_ item: R, in section: S, at indexToInsert: Int) {
        guard let index = sections.firstIndex(where: { $0.section == section }) else { return }

        var items = sections[index].items
        items.insert(item, at: indexToInsert)
        sections[index].items = items
    }

    public mutating func removeAll(item: R) {
        for (i, section) in sections.enumerated() {
            var items = section.items
            items.removeAll { $0 == item }
            sections[i].items = items
        }
    }

    public func indexPath(item: R, section: S? = nil) -> IndexPath? {
        for (sectionIndex, aSection) in sections.enumerated() {
            for (itemIndex, anItem) in aSection.items.enumerated() where item == anItem {
                if let section = section, section != aSection.section {
                    continue
                }

                return IndexPath(row: itemIndex, section: sectionIndex)
            }
        }

        return nil
    }

    public func items(of section: S) -> [R]? {
        return sections.first(where: { $0.section == section })?.items
    }
}
