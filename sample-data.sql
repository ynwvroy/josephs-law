-- Joseph's Law - Sample Data Script
-- Run this in your Supabase SQL Editor after the schema

-- ============================================
-- UPDATE USER ROLES
-- ============================================

-- Update Joseph to admin
UPDATE users 
SET role = 'admin', 
    full_name = 'Joseph Admin',
    account_id = 'MRX_ADMIN001'
WHERE email = 'joseph@gmail.com';

-- Update Victor to lawyer
UPDATE users 
SET role = 'lawyer', 
    full_name = 'Victor Lawyer',
    account_id = 'MRX_LAW001'
WHERE email = 'victor@gmail.com';

-- Update Mary to client
UPDATE users 
SET role = 'client', 
    full_name = 'Mary Client',
    account_id = 'MRX_CLI001'
WHERE email = 'mary@gmail.com';

-- ============================================
-- GET USER IDs FOR REFERENCES
-- ============================================
-- Note: These IDs will be auto-generated, we'll use subqueries in inserts

-- ============================================
-- INSERT CLIENTS
-- ============================================

INSERT INTO clients (name, phone_number, email, address) VALUES
('John Doe', '+254712345678', 'john.doe@example.com', '123 Nairobi Street, Nairobi'),
('Jane Smith', '+254723456789', 'jane.smith@example.com', '456 Mombasa Road, Mombasa'),
('Robert Johnson', '+254734567890', 'robert.j@example.com', '789 Kisumu Avenue, Kisumu'),
('Emily Davis', '+254745678901', 'emily.d@example.com', '321 Nakuru Highway, Nakuru'),
('Michael Wilson', '+254756789012', 'michael.w@example.com', '654 Eldoret Lane, Eldoret');

-- ============================================
-- INSERT STAFF
-- ============================================

INSERT INTO staff (name, role, phone, email, hired_date, status) VALUES
('Sarah Kamau', 'Paralegal', '+254711111111', 'sarah.k@josephslaw.com', '2024-01-15', 'Active'),
('David Ochieng', 'Legal Assistant', '+254722222222', 'david.o@josephslaw.com', '2024-02-01', 'Active'),
('Grace Wanjiku', 'Secretary', '+254733333333', 'grace.w@josephslaw.com', '2024-03-10', 'Active'),
('James Mutua', 'Accountant', '+254744444444', 'james.m@josephslaw.com', '2024-01-20', 'Active'),
('Lucy Akinyi', 'Receptionist', '+254755555555', 'lucy.a@josephslaw.com', '2024-04-05', 'Active');

-- ============================================
-- INSERT CASES
-- ============================================

INSERT INTO cases (case_number, title, case_stage, status, case_type, client_id, description, lead_lawyer_id, filed_date, opposing_party, opposing_lawyer, billing_status) VALUES
('CASE-2024-001', 'Land Dispute - Nairobi', 'Trial', 'Active', 'Civil', (SELECT id FROM users WHERE email = 'mary@gmail.com'), 'Dispute over land ownership in Nairobi CBD', (SELECT id FROM users WHERE email = 'victor@gmail.com'), '2024-05-01', 'ABC Properties Ltd', 'Adv. Peter Kimani', 'Pending'),
('CASE-2024-002', 'Divorce Settlement', 'Mediation', 'In Progress', 'Family Law', (SELECT id FROM users WHERE email = 'mary@gmail.com'), 'Divorce proceedings with asset division', (SELECT id FROM users WHERE email = 'victor@gmail.com'), '2024-06-15', 'John Smith', 'Adv. Mary Wanjiku', 'Partial'),
('CASE-2024-003', 'Contract Breach', 'Pre-trial', 'Active', 'Commercial', (SELECT id FROM users WHERE email = 'mary@gmail.com'), 'Breach of service contract between companies', (SELECT id FROM users WHERE email = 'victor@gmail.com'), '2024-07-20', 'XYZ Corporation', 'Adv. James Omondi', 'Unpaid'),
('CASE-2024-004', 'Criminal Defense', 'Investigation', 'Active', 'Criminal', (SELECT id FROM users WHERE email = 'mary@gmail.com'), 'Defense in fraud case', (SELECT id FROM users WHERE email = 'victor@gmail.com'), '2024-08-01', 'State', 'Prosecution Office', 'Paid'),
('CASE-2024-005', 'Employment Dispute', 'Arbitration', 'Pending', 'Labor', (SELECT id FROM users WHERE email = 'mary@gmail.com'), 'Wrongful termination claim', (SELECT id FROM users WHERE email = 'victor@gmail.com'), '2024-09-10', 'Tech Solutions Ltd', 'Adv. Grace Njeri', 'Pending');

-- ============================================
-- INSERT APPOINTMENTS
-- ============================================

INSERT INTO appointments (user_id, organization_id, date, time, status, notes) VALUES
((SELECT id FROM users WHERE email = 'mary@gmail.com'), NULL, '2024-10-25', '10:00:00', 'Scheduled', 'Initial consultation for land dispute'),
((SELECT id FROM users WHERE email = 'mary@gmail.com'), NULL, '2024-10-26', '14:30:00', 'Scheduled', 'Follow-up on divorce case'),
((SELECT id FROM users WHERE email = 'victor@gmail.com'), NULL, '2024-10-27', '09:00:00', 'Confirmed', 'Court appearance - Case 001'),
((SELECT id FROM users WHERE email = 'joseph@gmail.com'), NULL, '2024-10-28', '11:00:00', 'Scheduled', 'Monthly staff meeting'),
((SELECT id FROM users WHERE email = 'mary@gmail.com'), NULL, '2024-10-29', '15:00:00', 'Pending', 'Document review session');

-- ============================================
-- INSERT MEMOS
-- ============================================

INSERT INTO memos (case_id, author_id, title, content, status, priority, visibility, tags) VALUES
((SELECT id FROM cases WHERE case_number = 'CASE-2024-001'), (SELECT id FROM users WHERE email = 'victor@gmail.com'), 'Land Title Verification', 'Need to verify land title deed authenticity before next hearing', 'Active', 'High', 'Team', ARRAY['urgent', 'land']),
((SELECT id FROM cases WHERE case_number = 'CASE-2024-002'), (SELECT id FROM users WHERE email = 'victor@gmail.com'), 'Asset Valuation Report', 'Request asset valuation from certified valuer', 'Pending', 'Medium', 'Team', ARRAY['assets', 'valuation']),
((SELECT id FROM cases WHERE case_number = 'CASE-2024-003'), (SELECT id FROM users WHERE email = 'joseph@gmail.com'), 'Contract Review', 'Review original contract terms for breach analysis', 'Active', 'High', 'Internal', ARRAY['contract', 'review']),
((SELECT id FROM cases WHERE case_number = 'CASE-2024-004'), (SELECT id FROM users WHERE email = 'victor@gmail.com'), 'Evidence Collection', 'Gather all financial documents for defense', 'In Progress', 'Critical', 'Team', ARRAY['evidence', 'urgent']),
((SELECT id FROM cases WHERE case_number = 'CASE-2024-005'), (SELECT id FROM users WHERE email = 'joseph@gmail.com'), 'Employment Records', 'Obtain employment contract and termination letter', 'Pending', 'Medium', 'Team', ARRAY['employment', 'records']);

-- ============================================
-- INSERT NOTES
-- ============================================

INSERT INTO notes (title, content, author_id, case_id) VALUES
('Client Meeting Notes', 'Client expressed concerns about timeline. Need to expedite process.', (SELECT id FROM users WHERE email = 'victor@gmail.com'), (SELECT id FROM cases WHERE case_number = 'CASE-2024-001')),
('Court Proceedings', 'Judge requested additional evidence by next hearing date.', (SELECT id FROM users WHERE email = 'victor@gmail.com'), (SELECT id FROM cases WHERE case_number = 'CASE-2024-002')),
('Strategy Discussion', 'Agreed to pursue settlement negotiations before trial.', (SELECT id FROM users WHERE email = 'joseph@gmail.com'), (SELECT id FROM cases WHERE case_number = 'CASE-2024-003')),
('Witness Statement', 'Witness testimony scheduled for next month.', (SELECT id FROM users WHERE email = 'victor@gmail.com'), (SELECT id FROM cases WHERE case_number = 'CASE-2024-004')),
('Documentation Update', 'All required documents submitted to opposing counsel.', (SELECT id FROM users WHERE email = 'victor@gmail.com'), (SELECT id FROM cases WHERE case_number = 'CASE-2024-005'));

-- ============================================
-- INSERT NOTIFICATIONS
-- ============================================

INSERT INTO notifications (user_id, title, message, type, is_read) VALUES
((SELECT id FROM users WHERE email = 'mary@gmail.com'), 'Appointment Reminder', 'Your appointment is scheduled for tomorrow at 10:00 AM', 'appointment', false),
((SELECT id FROM users WHERE email = 'victor@gmail.com'), 'Case Update', 'New documents uploaded for Case 2024-001', 'case', false),
((SELECT id FROM users WHERE email = 'joseph@gmail.com'), 'Staff Meeting', 'Monthly staff meeting on October 28th at 11:00 AM', 'meeting', false),
((SELECT id FROM users WHERE email = 'mary@gmail.com'), 'Payment Due', 'Invoice #INV-001 is due for payment', 'payment', false),
((SELECT id FROM users WHERE email = 'victor@gmail.com'), 'Court Notice', 'Court appearance scheduled for October 27th', 'court', false);

-- ============================================
-- INSERT PAYMENTS
-- ============================================

INSERT INTO payments (name, address, phone, email, amount, status, payment_date, case_id) VALUES
('John Doe', '123 Nairobi Street', '+254712345678', 'john.doe@example.com', 50000.00, 'Paid', '2024-10-01', (SELECT id FROM cases WHERE case_number = 'CASE-2024-001')),
('Jane Smith', '456 Mombasa Road', '+254723456789', 'jane.smith@example.com', 75000.00, 'Partial', '2024-10-05', (SELECT id FROM cases WHERE case_number = 'CASE-2024-002')),
('Robert Johnson', '789 Kisumu Avenue', '+254734567890', 'robert.j@example.com', 100000.00, 'Pending', '2024-10-10', (SELECT id FROM cases WHERE case_number = 'CASE-2024-003')),
('Emily Davis', '321 Nakuru Highway', '+254745678901', 'emily.d@example.com', 60000.00, 'Paid', '2024-10-15', (SELECT id FROM cases WHERE case_number = 'CASE-2024-004')),
('Michael Wilson', '654 Eldoret Lane', '+254756789012', 'michael.w@example.com', 45000.00, 'Overdue', '2024-09-20', (SELECT id FROM cases WHERE case_number = 'CASE-2024-005'));

-- ============================================
-- INSERT TASKS
-- ============================================

INSERT INTO tasks (title, description, priority, due_date, status, assigned_to) VALUES
('Prepare Court Documents', 'Draft and review all court documents for Case 001', 'High', '2024-10-24', 'In Progress', (SELECT id FROM users WHERE email = 'victor@gmail.com')),
('Client Follow-up', 'Call client regarding missing documents', 'Medium', '2024-10-25', 'Pending', (SELECT id FROM users WHERE email = 'victor@gmail.com')),
('Research Case Law', 'Research relevant case precedents', 'High', '2024-10-26', 'Not Started', (SELECT id FROM users WHERE email = 'victor@gmail.com')),
('Schedule Meeting', 'Schedule strategy meeting with team', 'Low', '2024-10-28', 'Pending', (SELECT id FROM users WHERE email = 'joseph@gmail.com')),
('File Court Papers', 'Submit filed documents to court registry', 'Critical', '2024-10-23', 'Completed', (SELECT id FROM users WHERE email = 'victor@gmail.com'));

-- ============================================
-- INSERT DIRECTORY
-- ============================================

INSERT INTO directory (name, description, price, images, stock, category) VALUES
('Legal Consultation', 'Initial legal consultation session', 5000.00, ARRAY['consultation.jpg'], 100, 'Services'),
('Contract Review', 'Review and analysis of legal contracts', 15000.00, ARRAY['contract.jpg'], 50, 'Services'),
('Court Representation', 'Full court representation services', 50000.00, ARRAY['court.jpg'], 20, 'Services'),
('Legal Documentation', 'Preparation of legal documents', 8000.00, ARRAY['docs.jpg'], 200, 'Services'),
('Mediation Services', 'Professional mediation services', 25000.00, ARRAY['mediation.jpg'], 30, 'Services');

-- ============================================
-- INSERT DOCUMENT UPLOADS
-- ============================================

INSERT INTO document_uploads (title, category, public_url, case_id, uploaded_by) VALUES
('Land Title Deed', 'Property', 'https://tnsqbyoyzijseecikiuu.supabase.co/storage/v1/object/public/documents/land-title.pdf', (SELECT id FROM cases WHERE case_number = 'CASE-2024-001'), (SELECT id FROM users WHERE email = 'victor@gmail.com')),
('Marriage Certificate', 'Family Law', 'https://tnsqbyoyzijseecikiuu.supabase.co/storage/v1/object/public/documents/marriage-cert.pdf', (SELECT id FROM cases WHERE case_number = 'CASE-2024-002'), (SELECT id FROM users WHERE email = 'victor@gmail.com')),
('Service Contract', 'Commercial', 'https://tnsqbyoyzijseecikiuu.supabase.co/storage/v1/object/public/documents/service-contract.pdf', (SELECT id FROM cases WHERE case_number = 'CASE-2024-003'), (SELECT id FROM users WHERE email = 'joseph@gmail.com')),
('Financial Records', 'Evidence', 'https://tnsqbyoyzijseecikiuu.supabase.co/storage/v1/object/public/documents/financial-records.pdf', (SELECT id FROM cases WHERE case_number = 'CASE-2024-004'), (SELECT id FROM users WHERE email = 'victor@gmail.com')),
('Employment Contract', 'Labor', 'https://tnsqbyoyzijseecikiuu.supabase.co/storage/v1/object/public/documents/employment-contract.pdf', (SELECT id FROM cases WHERE case_number = 'CASE-2024-005'), (SELECT id FROM users WHERE email = 'victor@gmail.com'));

-- ============================================
-- VERIFICATION QUERIES (Optional)
-- ============================================

-- Check user roles
-- SELECT email, role, full_name FROM users;

-- Check data counts
-- SELECT 'clients' as table_name, COUNT(*) as count FROM clients
-- UNION ALL
-- SELECT 'cases', COUNT(*) FROM cases
-- UNION ALL
-- SELECT 'appointments', COUNT(*) FROM appointments
-- UNION ALL
-- SELECT 'staff', COUNT(*) FROM staff
-- UNION ALL
-- SELECT 'memos', COUNT(*) FROM memos
-- UNION ALL
-- SELECT 'notes', COUNT(*) FROM notes
-- UNION ALL
-- SELECT 'notifications', COUNT(*) FROM notifications
-- UNION ALL
-- SELECT 'payments', COUNT(*) FROM payments
-- UNION ALL
-- SELECT 'tasks', COUNT(*) FROM tasks
-- UNION ALL
-- SELECT 'directory', COUNT(*) FROM directory
-- UNION ALL
-- SELECT 'document_uploads', COUNT(*) FROM document_uploads;
