//
//  CalendarKitViewController.swift
//  CareerCrowder
//
//  Created by Alan Frank on 11/7/21.
//

import UIKit
import CalendarKit
import EventKit
import EventKitUI

class CalendarKitViewController: DayViewController, EKEventEditViewDelegate {
    
    private let eventStore = EKEventStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calendar"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        requestAccessToCalendar()
        subscribeToNotifications()
        // Do any additional setup after loading the view.
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: .event) { success, error in
            
        }
    }
    
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(storeChanged(_:)), name: .EKEventStoreChanged, object: nil)
    }
    
    @objc func storeChanged(_ notification: Notification) {
        reloadData()
    }
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        let startDate = date
        var oneDayComponents = DateComponents()
        oneDayComponents.day = 1
        let endDate = calendar.date(byAdding: oneDayComponents, to: startDate)!
        
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        
        let eventKitEvents = eventStore.events(matching: predicate)
        
        let calendarKitEvents = eventKitEvents.map(EKWrapper.init)
        
        return calendarKitEvents
    }
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let ckEvent = eventView.descriptor as? EKWrapper else {
            return
        }
        
        let ekEvent = ckEvent.ekEvent
        presentDetailView(ekEvent)
    }
    
    private func presentDetailView(_ ekEvent: EKEvent) {
        let eventViewController = EKEventViewController()
        eventViewController.event = ekEvent
        eventViewController.allowsCalendarPreview = true
        eventViewController.allowsEditing = true
        navigationController?.pushViewController(eventViewController, animated: true)
    }
    
    override func dayViewDidLongPressEventView(_ eventView: EventView) {
        endEventEditing()
        guard let ckEvent = eventView.descriptor as? EKWrapper else {
            return
        }
        beginEditing(event: ckEvent, animated: true)
    }
    
    override func dayView(dayView: DayView, didUpdate event: EventDescriptor) {
        guard let editingEvent = event as? EKWrapper else { return }
        if let originalEvent = event.editedEvent {
            editingEvent.commitEditing()
            
            if originalEvent === editingEvent {
                // Event creation flow
                presentEditingViewForEvent(editingEvent.ekEvent)
            }
            else {
                // Editing flow
                try! eventStore.save(editingEvent.ekEvent, span: .thisEvent)
            }
            
            
        }
        reloadData()
    }
    
    
    
    
    
    
//    @IBAction func addEventButton(_ sender: Any) {
//        newEventFromButton(editingEvent.ekEvent)
//    }
//
//    func newEventFromButton(_ ekEvent: EKEvent) {
//        let editingViewController = EKEventEditViewController()
//        editingViewController.editViewDelegate = self
//        editingViewController.event = ekEvent
//        editingViewController.eventStore = eventStore
//        present(editingViewController, animated: true, completion: nil)
//    }
    
    
    
    
    
    
    func presentEditingViewForEvent(_ ekEvent: EKEvent) {
        let editingViewController = EKEventEditViewController()
        editingViewController.editViewDelegate = self
        editingViewController.event = ekEvent
        editingViewController.eventStore = eventStore
        present(editingViewController, animated: true, completion: nil)
    }
    
    override func dayView(dayView: DayView, didTapTimelineAt date: Date) {
        endEventEditing()
    }
    
    override func dayViewDidBeginDragging(dayView: DayView) {
        endEventEditing()
    }
    
    override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
        let newEKEvent = EKEvent(eventStore: eventStore)
        newEKEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        var oneHourComponents = DateComponents()
        oneHourComponents.hour = 1
        
        let endDate = calendar.date(byAdding: oneHourComponents, to: date)
        
        newEKEvent.startDate = date
        newEKEvent.endDate = endDate
        newEKEvent.title = "New Event"
        
        let newEKWrapper = EKWrapper(eventKitEvent: newEKEvent)
        newEKWrapper.editedEvent = newEKWrapper
        
        create(event: newEKWrapper, animated: true)
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        endEventEditing()
        reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
}
